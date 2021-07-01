import os
from subprocess import check_output

encrypt_secret_values = "{{ cookiecutter.encrypt_secret_values }}".lower() in ["y", "yes", "true", "1"]
app_slug = "{{ cookiecutter.app_slug }}"
key_passphrase = "{{ cookiecutter.key_passphrase }}"

secret_files = []
# create symlinked shared values file
items = os.listdir(os.path.join(".", "helm_vars"))
for item in items:
    path = os.path.join(".", "helm_vars", item)
    if os.path.isdir(path):
        os.symlink(
            os.path.join("..", "values.yaml"),
            os.path.join(path, "values.shared.yaml")
        )
        for file in os.listdir(path):
            if file.startswith("secrets"):
                secret_files.append(os.path.join(path, file))

# encrypt with sops
if encrypt_secret_values:
    import gnupg

    print("You selected to encrypt secret values using 'sops' with a generate private key.")
    # generate a new private key
    gpg = gnupg.GPG()
    gpg.encoding = 'utf-8'
    # generate key
    key_options = {
        "key_type": "RSA",
        "key_length": 2084,
        "name_email": "{{ cookiecutter.key_email }}",
        "name_real": "{{ cookiecutter.key_user }}",
        "name_comment": "Generated with cookiecutter",
        "expire_date": 0,
    }
    if key_passphrase:
        key_options.update({"passphrase": key_passphrase})
        print("Private key with passphrase set")
    else:
        key_options.update({"no_protection": True})
        print("Private key NO passphrase set")

    input_data = gpg.gen_key_input(**key_options)
    key = gpg.gen_key(input_data)

    # export keys
    if key_passphrase:
        ascii_armored_public_keys = gpg.export_keys(key.fingerprint)
        ascii_armored_private_keys = gpg.export_keys(keyids=key.fingerprint, secret=True,
                                                     passphrase=key_passphrase)
    else:
        ascii_armored_public_keys = gpg.export_keys(key.fingerprint, expect_passphrase=False)
        ascii_armored_private_keys = gpg.export_keys(keyids=key.fingerprint, secret=True, expect_passphrase=False)

    with open(os.path.join("..", f"{app_slug}-private.key.rsa"), 'w') as f:
        f.write(ascii_armored_private_keys)

    # encrypt files
    for secret_file in secret_files:
        check_output(["sops", "--encrypt", "--in-place",
                      "--pgp", key.fingerprint, secret_file])
else:
    print("You selected to NOT encrypt secret values.")

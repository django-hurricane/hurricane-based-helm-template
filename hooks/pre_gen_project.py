import re
import sys

try:
    import gnupg
except ImportError:
    print("Warning: there is a problem with the import of 'gnupg' which is required for encrypting secret value files.")

APP_SLUG_REGEX = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

app_slug = '{{ cookiecutter.app_slug }}'

if not re.match(APP_SLUG_REGEX, app_slug):
    print('ERROR: %s is not a valid app slug. It must resemble a valid domain name.' % app_slug)

    # exits with status 1 to indicate failure
    sys.exit(1)

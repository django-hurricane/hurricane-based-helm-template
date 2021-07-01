try:
    import gnupg
except ImportError:
    print("Warning: there is a problem with the import of 'gnupg' which is required for encrypting secret value files.")

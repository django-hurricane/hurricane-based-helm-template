# hurricane-based-helm-template
This is a cookiecutter template for *Django-Hurricane*-based Helm charts.

---


## Purpose

This template is used to scaffold a `Helm` chart for applications using [django-hurricane](https://django-hurricane.readthedocs.io/en/latest/).
It sets required environment variables and should replace 90% for all `docker-compose` setups with django and a postgresql.

## Installation

Firstly, you will need to install [cookiecutter](https://cookiecutter.readthedocs.io/en/latest/):

```bash
pip install cookiecutter
```
If you want to encrypt the secret Helm values, please install [gnupg](https://docs.red-dove.com/python-gnupg/),
too.
```bash
pip install python-gnupg
```

---

## Usage

Create a new Helm chart with
```bash
cookiecutter gh:Blueshoe/hurricane-based-helm-template
```
and answer the questions accordingly.

# Volumes
It is generally considered more secure to run containers with a user other than `root`. Our
Dockerfiles usually incorporate a special user to run the application. For development
environments such as `k3d` we're using `local-path` provisioner for local volume creation.
This storage class does not honor the `fsGroup` option and volumes get still mounted with `root` owner 
which leads to permission issues.  
Anyway, you can set `volumePermissions.enabled: true` which starts an `initContainer` that simply
`chown`s the requested volume mounts. However, you have to set 
`podSecurityContext.fsGroup and podSecurityContext.runAsUser` to make this work. 

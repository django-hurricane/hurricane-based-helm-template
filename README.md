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

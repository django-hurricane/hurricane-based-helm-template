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
Anyway, `volumePermissions.enabled: true` is set as default, which starts an `initContainer` that simply
`chown`s the requested volume mounts. However, you have to set 
`podSecurityContext.fsGroup and podSecurityContext.runAsUser` to make this work. 

## How can I test my generated charts

The simplest solution to test your generated Helm charts is by applying them to an ephemeral cluster using `k3d`.

### Create a local custer
```bash
k3d cluster create my-test
```
Make sure your local `kubectl` connection is set to the cluster which you just created.

### Prepare Helm dependencies
```bash
helm dep up <appname>/
```

### Install the charts
```bash
helm install my-release <appname>/
```
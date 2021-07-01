{% raw -%}

{{/*
Wrap env variables
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.envVariables"{% raw %} -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
- name: DJANGO_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-django-secrets
      key: DJANGO_SECRET_KEY
- name: DATABASE_HOST
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-django-secrets
      key: postgresql-host
- name: DATABASE_USER
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-django-secrets
      key: postgresql-user
- name: DATABASE_NAME
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-django-secrets
      key: postgresql-name
- name: DATABASE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-django-secrets
      key: postgresql-password
- name: DJANGO_USE_S3
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-django-secrets
      key: DJANGO_USE_S3
- name: DJANGO_AWS_S3_ACCESS_KEY_ID
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-django-secrets
      key: DJANGO_AWS_S3_ACCESS_KEY_ID
- name: DJANGO_AWS_S3_SECRET_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-django-secrets
      key: DJANGO_AWS_S3_SECRET_ACCESS_KEY
- name: DJANGO_AWS_S3_BUCKET_NAME
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-django-secrets
      key: DJANGO_AWS_S3_BUCKET_NAME
- name: DJANGO_AWS_REGION
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-django-secrets
      key: DJANGO_AWS_REGION
{{- end -}}

{%- endraw %}
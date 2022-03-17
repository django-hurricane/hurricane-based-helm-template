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
{{- end -}}

{{/*
Wrap env variables for amqp-connect (rabbitmq-initContainer)
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.envVariablesAmqpConnect"{% raw %} -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
- name: AMQP_HOST
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-rabbitmq-custom
      key: rabbitmq-host
- name: AMQP_VHOST
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-rabbitmq-custom
      key: rabbitmq-vhost
- name: AMQP_USERNAME
  value: {{ .Values.rabbitmq.auth.username | quote }}
- name: AMQP_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $name }}-rabbitmq-custom
      key: rabbitmq-password
- name: AMQP_PORT
  value: "5672"
- name: SLEEP_DURATION
  value: "5"
- name: MAX_RETRIES
  value: "10"
- name: SENTRY_DSN
  value: {{ .Values.sentryDSN | quote }}
{{- end -}}

{%- endraw %}
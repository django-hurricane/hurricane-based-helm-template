{% raw -%}

{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.name"{% raw %} -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.fullname"{% raw %} -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name for celery worker.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.fullnameWorker"{% raw %} -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 56 | trimSuffix "-" -}}-worker
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}-worker
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 56 | trimSuffix "-" -}}-worker
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 56 | trimSuffix "-" -}}-worker
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name for celery beat.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.fullnameBeat"{% raw %} -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 58 | trimSuffix "-" -}}-beat
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}-beat
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 58 | trimSuffix "-" -}}-beat
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 58 | trimSuffix "-" -}}-beat
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.chart"{% raw %} -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels for deployment
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.labels"{% raw %} -}}
helm.sh/chart: {{ include {% endraw %}"{{ cookiecutter.app_slug }}.chart"{% raw %} . }}
{{ include {% endraw %}"{{ cookiecutter.app_slug }}.selectorLabels"{% raw %} . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels for deployment
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.selectorLabels"{% raw %} -}}
app.kubernetes.io/name: {{ include {% endraw %}"{{ cookiecutter.app_slug }}.name"{% raw %} . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Common labels for celery worker
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.labelsWorker"{% raw %} -}}
helm.sh/chart: {{ include {% endraw %}"{{ cookiecutter.app_slug }}.chart"{% raw %} . }}
{{ include {% endraw %}"{{ cookiecutter.app_slug }}.selectorLabelsWorker"{% raw %} . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels for celery worker
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.selectorLabelsWorker"{% raw %} -}}
app.kubernetes.io/name: {{ include {% endraw %}"{{ cookiecutter.app_slug }}.name"{% raw %} . }}-worker
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Common labels for celery beat
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.labelsBeat"{% raw %} -}}
helm.sh/chart: {{ include {% endraw %}"{{ cookiecutter.app_slug }}.chart"{% raw %} . }}
{{ include {% endraw %}"{{ cookiecutter.app_slug }}.selectorLabelsBeat"{% raw %} . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels for celery beat
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.selectorLabelsBeat"{% raw %} -}}
app.kubernetes.io/name: {{ include {% endraw %}"{{ cookiecutter.app_slug }}.name"{% raw %}  . }}-beat
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define {% endraw %}"{{ cookiecutter.app_slug }}.serviceAccountName"{% raw %} -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include {% endraw %}"{{ cookiecutter.app_slug }}.fullname"{% raw %} .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{%- endraw %}
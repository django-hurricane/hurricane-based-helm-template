{% raw %}

{{/* ######### Registry related templates */}}

{{- define {% endraw %}"{{ cookiecutter.app_slug }}.imagePullSecret"{% raw %} }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.imageCredentials.registry (printf "%s:%s" .Values.imageCredentials.username .Values.imageCredentials.password | b64enc) | b64enc }}
{{- end }}

{% endraw %}
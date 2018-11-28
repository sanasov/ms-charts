{{- define "postgreagentppz.fullname" -}}
{{- printf "%s" .Values.postgreagentppz.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
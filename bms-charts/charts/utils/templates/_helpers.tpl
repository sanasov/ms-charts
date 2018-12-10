{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- .Values.nameOverride | default .Chart.Name  | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- $name := .Values.nameOverride | default .Chart.Name -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "proxy" -}}
{{- printf "http://%s:%v" .host .port -}}
{{- end -}}

{{- define "noproxy" -}}
{{- range $index, $value := . -}}
{{- if gt $index 0 -}}
{{ "," }}
{{- end -}}
{{ $value }}
{{- end -}}
{{- end -}}

{{- define "proxyenv" -}}
{{- if .Values.global.proxy -}}
- name: HTTP_PROXY
  value: "{{ template "proxy" .Values.global.proxy.http }}"
- name: HTTPS_PROXY
  value: "{{ template "proxy" .Values.global.proxy.https }}"
- name: NO_PROXY
  value: "{{ template "noproxy" .Values.global.proxy.none }}"
- name: _JAVA_OPTIONS
  value: "-Dhttps.proxyHost={{ .Values.global.proxy.https.host }} -Dhttps.proxyPort={{ .Values.global.proxy.https.port }} -Dhttp.proxyHost={{ .Values.global.proxy.http.host }} -Dhttp.proxyPort={{ .Values.global.proxy.http.port }} -DproxySet=true -Djava.net.useSystemProxies=true"
{{- end -}}
{{- end -}}

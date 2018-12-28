{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "server.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s"  $name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*  Manage the labels for each entity  */}}
{{- define "server.labels" -}}
labels:
  app: {{ .Values.appName }}
  type: {{ .Values.appType }}
  fullname: {{ template "server.fullname" . }}
  chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
  release: {{ .Release.Name }}
  heritage: {{ .Release.Service }}
{{- if .Values.customLabels }}
{{ toYaml .Values.customLabels | indent 2 }}
{{- end }}
{{- end -}}

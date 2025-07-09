{{- define "webapp.labels" -}}
app.kubernetes.io/name: {{ include "webapp-chart-name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "webapp-chart-name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "webapp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{- default .Release.Name .Values.serviceAccount.name }}
{{- else -}}
    {{- default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
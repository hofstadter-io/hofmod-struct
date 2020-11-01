package {{ .MODEL.PackageName }}

{{ template "go/imports.go" . }}

{{ template "go/type.go" . }}

{{ template "go/views.go" . }}

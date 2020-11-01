{{ $ROOT := . }}
{{ range $i, $VIEW := .MODEL.Views }}
type {{ $ROOT.MODEL.ModelName }}{{ $VIEW.ViewName }}View struct {
	{{ range $VIEW.Fields }}
	{{ template "go/field.go" . }}
	{{end}}
}
{{ end }}

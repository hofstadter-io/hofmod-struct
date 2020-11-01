type {{ .MODEL.ModelName }} struct {
	{{ range $i, $F := .MODEL.Fields }}
	{{ template "go/field.go" $F }}
	{{end}}
}

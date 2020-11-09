type {{ .MODEL.ModelName }} struct {
	{{ if .MODEL.ORM }}
	ID uuid.UUID

	CreatedAt time.Time

	UpdatedAt time.Time
	{{ if .MODEL.SoftDelete }}
	DeletedAt time.Time
	{{ end }}
	{{ end }}

	{{ range $i, $F := .MODEL.Fields }}
	{{ template "go/field.go" $F }}
	{{end}}
}

package gen

import (
	"list"

  "github.com/hofstadter-io/hof/schema"
)

#HofGenerator: schema.#HofGenerator & {
  Datamodel: schema.#Datamodel
  Outdir?: string | *"./"

  // Internal
  In: {
    DM: Datamodel
  }

  PackageName: string | *"github.com/hofstadter-io/hofmod-server"

  PartialsDir:  "./partials/"
  TemplatesDir: "./templates/"

	// Actual files generated by hof, flattened into a single list
  Out: [...schema.#HofGeneratorFile] & list.FlattenN(All , 1)

  // Combine everything together and output files that might need to be generated
  All: [
   [ for _, F in Modelsets { F } ],
   [ for _, F in Models { F } ],
  ]

  // Sub command tree
  Modelsets: [...schema.#HofGeneratorFile] & list.FlattenN([[
    for _, M in Datamodel.Modelsets
    {
      In: {
        MODELSET: {
          M
          PackageName: "dm"
        }
      }
      TemplateName: "go/modelset.go"
      Filepath: "\(Outdir)/\(M.Name).go"
		}
	]], 1)

  MPP: [ for P in Modelsets if len(P.In.MODELSET.Models) > 0 {
    [ for M in P.In.MODELSET.Models { M,  Parent: { Name: P.In.MODELSET.Name } }]
  }]
  Models: [...schema.#HofGeneratorFile] & [ // List comprehension
    for _, M in list.FlattenN(MPP, 1)
    {
      In: {
				MODEL: {
					M
					PackageName: "\(M.Parent.Name)"
				}
      }
      TemplateName: "go/model.go"
      Filepath: "\(Outdir)/\(M.Parent.Name)/\(M.Name).go"
    }
  ]

	...
}

package example

import (
	"list"

	schema "github.com/hofstadter-io/hof/schema"

	"github.com/hofstadter-io/hofmod-struct/gen"
)

DM: _ @gen(dm,datamodel)
DM: gen.#HofGenerator & {
	Datamodel: MyDM
	Outdir: "./dm/"

	// Needed because we are using the generator from within it's directory
	PackageName: ""
}

MyDM: schema.#Datamodel & {
	Name: "MyDM"

	// Map of Modelsets, key is the name
	Modelsets: {
		// Example modelset "MyModelset"
		MyModelset: schema.#Modelset & {

			// Map of models
			Models: {

				user: {
					// Map of user fields, with common fields added
					Fields: {
						// embed common database fields
						schema.#CommonFields
						email: schema.#Email
						password: schema.#Password
					}

					Views: {
						login: {
							Fields: {
								email: user.Fields.email
								password: user.Fields.password
							}
						}
						info: {
							_exclude: ["password", "CreatedAt", "DeletedAt"]
							Fields: {
								for k, v in user.Fields {
									if !list.Contains(_exclude, k) {
										"\(k)": v
									}
								}
							}
						}
					}
				}

				profile: {
					Fields: {
						schema.#CommonFields
						fname: schema.#String
						mname: schema.#String
						lname: schema.#String
					}
				}

			}
		}
	}
}


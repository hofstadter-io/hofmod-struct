package example

import (
	schema "github.com/hofstadter-io/hof/schema"

	"github.com/hofstadter-io/hofmod-struct/gen"
)

DM: _ @gen(dm,datamodel)
DM: gen.#HofGenerator & {
	Datamodel: MyDM
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


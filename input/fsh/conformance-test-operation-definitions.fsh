Instance: validate-single
InstanceOf: OperationDefinition
Usage: #definition
* url = "https://num-compass.science/fhir/OperationDefinition/validate-single"
* status = #draft
* kind = #operation
* name = "ValidateSingleResource"
* title = "Validate single instance of arbitrary type"
* code = #validate-single
* purpose = "Provides a single operation for validating a resource of arbitrary type. Differs from the standard $validate operation in that it works (only) on the system level and requires the resource to be sent in the request. If validation against a specific profile is required, the corresponding canonical URI of the profile should be put in the `meta.profile` element of the submitted resource."
* system = true
* type = false
* instance = false
* resource[0] = #Resource
* parameter[0].name = #resource
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Resource to be validated"
* parameter[=].type = #Resource
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "List of any validation issues"
* parameter[=].type = #OperationOutcome

Instance: test-gecco-conformance
InstanceOf: OperationDefinition
Usage: #definition
* url = "https://num-compass.science/fhir/OperationDefinition/test-gecco-conformance"
* status = #draft
* kind = #operation
* name = "TestGeccoConformance"
* title = "Test GECCO conformance of an app based on test data"
* code = #test-gecco-conformance
* purpose = "Test GECCO conformance based on a test data set and information about the producing app"
* system = true
* type = false
* instance = false
* resource[0] = #Bundle
* inputProfile = "https://num-compass.science/fhir/StructureDefinition/NumConformanceTestBundle"
* parameter[0].name = #resource
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Bundle resource holding a FHIR document with all information needed for the conformance test"
* parameter[=].type = #Resource
* parameter[+].name = #opsOutReturn
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "List of any validation issues - returned if one or more tests fail"
* parameter[=].type = #OperationOutcome
* parameter[+].name = #pdfReturn
* parameter[=].use = #out
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "PDF document documenting successful test - returned if all tests pass"
* parameter[=].type = #Binary

Instance: list-conformance-resources
InstanceOf: OperationDefinition
Usage: #definition
* url = "https://num-compass.science/fhir/OperationDefinition/list-conformance-resources"
* status = #draft
* kind = #operation
* name = "ListConformanceResources"
* title = "List all loaded validation resources"
* code = #list-conformance-resources
* purpose = "Provide a simple way to get an overview over the loaded resources used for validation."
* system = true
* type = false
* instance = false
* parameter[0].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "List of the canonical URIs of all loaded validation resources"
* parameter[=].type = #String

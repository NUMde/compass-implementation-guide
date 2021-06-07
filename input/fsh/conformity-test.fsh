Profile: NumConformanceTestComposition
Parent: Composition
Id: NumConformanceTestComposition
* ^url = "https://num-compass.science/fhir/StructureDefinition/NumConformanceTestComposition"
* ^status = #draft
* status = #final (exactly)
* type = $loinc#68608-9
* section 1..
* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.ordered = false
* section ^slicing.rules = #open
* section ^short = "Section of the test data set"
* section contains
    software 1..1 and
    publishingOrg 1..1 and
    questionnaire 0..* and
    testData 1..
* section[software] ^short = "Software that generated the test data"
* section[software].code 1..
* section[software].code = $loinc#92040-5
* section[software].entry 1..1
* section[software].entry only Reference(NumConformanceDevice)
* section[publishingOrg] ^short = "Organization publishing the software"
* section[publishingOrg].code 1..
* section[publishingOrg].code = $loinc#91025-7
* section[publishingOrg].entry 1..1
* section[publishingOrg].entry only Reference(NumConformanceOrganization)
* section[questionnaire] ^short = "Questionnaires used in the software"
* section[questionnaire].code 1..
* section[questionnaire].code = $loinc#74468-0
* section[questionnaire].entry 1..
* section[questionnaire].entry only Reference(Questionnaire)
* section[testData] ^short = "Test data resources"
* section[testData].code 1..
* section[testData].code = $loinc#68839-0
* section[testData].entry 1..

Profile: NumConformanceDevice
Parent: Device
Id: NumConformanceDevice
* ^url = "https://num-compass.science/fhir/StructureDefinition/NumConformanceDevice"
* ^status = #draft
* deviceName 1..1
* deviceName.type = #manufacturer-name (exactly)
* type 1..
* type.coding.system = "http://snomed.info/sct" (exactly)
* type.coding.code = #706689003 (exactly)
* version 1..1
* owner 1..
* owner only Reference(NumConformanceOrganization)
* owner.reference 1..

Profile: NumConformanceDocumentReference
Parent: DocumentReference
Id: NumConformanceDocumentReference
* ^url = "https://num-compass.science/fhir/StructureDefinition/NumConformanceDocumentReference"
* ^status = #draft
* status = #current (exactly)
* date 1..
* description 1..
* content ..1
* content.attachment.contentType 1..
* content.attachment.contentType = #application/pdf (exactly)
* content.attachment.data 1..

Profile: NumConformanceOrganization
Parent: Organization
Id: NumConformanceOrganization
* ^url = "https://num-compass.science/fhir/StructureDefinition/NumConformanceOrganization"
* ^status = #draft
* name 1..
* telecom ^slicing.discriminator.type = #value
* telecom ^slicing.discriminator.path = "system"
* telecom ^slicing.rules = #open
* telecom contains email 1..1
* telecom[email].system 1..
* telecom[email].system = #email (exactly)
* telecom[email].value 1..
* address 1..1
* address.line 1..
* address.city 1..
* address.postalCode 1..
* address.country 1..

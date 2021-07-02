Profile:  CompassQuestionnaire
Parent:   Questionnaire
Id:       compass-questionnaire
Title:    "Compass Reference App Framwork Questionnaire"
Description: "A questionnaire, that is compatible with the native IBM App as well as the Data4Life WebApp and the Healex editor"
* url 1..1
* version 1..1
* item.linkId obeys compass-linkid-1 
* item obeys compass-linkid-2
* item obeys compass-mulitple-choice
* item.readOnly 0..0
// * item.repeats 0..0
* item.answerValueSet 0..0
* item.prefix 0..0
* item.enableWhen MS 
* item.enableBehavior MS 
* item.enableWhen.operator = #=
* item.answerOption.value[x] only string or integer
* item.extension contains
    GeccoTargetProfile named targetProfile 0..* MS and
    CompassGeccoItem named geccoItem 0..1 MS and 
    CompassInterversionId named interversionId 0..1 MS and
    LowRangeLabel named lowLabel 0..1 MS and
    HighRangeLabel named highLabel 0..1 MS

// TODO: Must-Support Slider
// TODO: Must-Support andere elemente
// TODO: Min/Max?


Invariant:  compass-linkid-1
Description: "linkId must be chain of numbers connected with dots"
Expression: "$this.matches('[0-9]+([.][0-9]+)*')"
Severity:   #error

Invariant:  compass-linkid-2
Description: "Child items must start with parent's linkId"
Expression: "$this.item.linkId.select(startsWith(%context.linkId))" //TODO: Test this expression
Severity:   #error

Invariant:  compass-mulitple-choice
Description: "repeats is not allowed for any item.type but choice"
Expression: "type = 'choice' or repeats.empty()" 
Severity:   #error

Extension: GeccoTargetProfile
Id: GeccoTargetProfile
Title: "Gecco-Profile"
Description: "Indicates that the element is mapped to a specific GECCO profile"
* ^context[0].type = #element
* ^context[0].expression = "Questionnaire.item"
* ^context[1].type = #element
* ^context[1].expression = "Questionnaire.item.item"
* value[x] only canonical

Extension: CompassGeccoItem
Id: CompassGeccoItem
Title: "Gecco-Item"
Description: "Mapping to an item in the Compass-LogicalModel"
* ^context[0].type = #element
* ^context[0].expression = "Questionnaire.item"
* ^context[1].type = #element
* ^context[1].expression = "Questionnaire.item.item"
* ^context[2].type = #element
* ^context[2].expression = "QuestionnaireResponse.item"
* ^context[3].type = #element
* ^context[3].expression = "QuestionnaireResponse.item.item"
* value[x] only Coding

Extension: CompassInterversionId
Id: CompassInterversionId
Title: "Interversion-Identifier"
Description: "Manually assigned itentifier that will not change with newer iterations of the questionnaire."
* ^context[0].type = #element
* ^context[0].expression = "Questionnaire.item"
* ^context[1].type = #element
* ^context[1].expression = "Questionnaire.item.item"
* ^context[2].type = #element
* ^context[2].expression = "QuestionnaireResponse.item"
* ^context[3].type = #element
* ^context[3].expression = "QuestionnaireResponse.item.item"
* value[x] only string

Extension: LowRangeLabel
Id: LowRangeLabel
Title: "LowRangeLabel"
Description: "For slider-based controls, label for the lower end of that slider."
* ^context[0].type = #element
* ^context[0].expression = "Questionnaire.item"
* ^context[1].type = #element
* ^context[1].expression = "Questionnaire.item.item"
* value[x] only string


Extension: HighRangeLabel
Id: HighRangeLabel
Title: "HighRangeLabel"
Description: "For slider-based controls, label for the higher end of that slider."
* ^context[0].type = #element
* ^context[0].expression = "Questionnaire.item"
* ^context[1].type = #element
* ^context[1].expression = "Questionnaire.item.item"
* value[x] only string

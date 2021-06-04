Profile:  CompassQuestionnaire
Parent:   Questionnaire
Id:       compass-questionnaire
Title:    "Compass Reference App Framwork Questionnaire"
Description: "A questionnaire, that is compatible with the native IBM App as well as the Data4Life WebApp and the Healex editor"
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
* item.definition MS 

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

Extension: CompassGeccoItem
Id: CompassGeccoItem
Title: "Gecco-Item"
Description: "Mapping to an item in the Compass-LogicalModel"
* value[x] only Coding


Extension: CompassInterversionId
Id:  CompassInterversionId
Title: "Interversion-Identifier"
Description: "Manually assigned itentifier that will not change with newer iterations of the questionnaire."
* value[x] only string



# NUMCompassIG
This is the implementation guide for the FHIR Questionnaires used by the reference app framework developed in [NUM Compass](https://num-compass.science/de/). It is based on the as-is state and supported features of the [native app](https://github.com/NUMde/compass-numapp-frontend) (developed by IBM) with additional documentation of the [GECCO](https://simplifier.net/ForschungsnetzCovid-19/) resource mapping extensions.

## Important constraints on the FHIR Questionnaire 
* Only JSON format is supported.
* The `Questionnaire.item` properties: readOnly, repeats, answerValueSet, prefix are not supported.
* The `Questionnaire.item.type` quantity is not supported. //TODO: Add constraint to the profile or add to the IBM reference app?
* The first level of items must be of type "group"
* `Questionnaire.item.answerOption.value` must be either string or integer.
* `Questionnaire.item.enableWhen` is only permitted in combination with the equals-operator.

For more information on how the IBM reference app handles the Questionnaire resource, see the [frontend documentation of the reference app](https://github.com/NUMde/compass-numapp-frontend/tree/main/docs/questionnaireRendering).

## Supported extensions
* http://hl7.org/fhir/R4/extension-questionnaire-itemcontrol.html ("slider" only)
* http://hl7.org/fhir/StructureDefinition/questionnaire-lowRangeLabel
* http://hl7.org/fhir/StructureDefinition/questionnaire-highRangeLabel
* http://hl7.org/fhir/StructureDefinition/questionnaire-sliderStepValue
* http://hl7.org/fhir/StructureDefinition/minValue
* http://hl7.org/fhir/StructureDefinition/maxValue

## Questionnaire.item-IDs 
* `linkId` must be of format "1.2.3" and determine order in Questionnaire. It should be assigned automatically.
* The Extension `https://num-compass.science/fhir/StructureDefinition/CompassInterversionId` can be used as identifier across different versions

In case of GECCO-Elements:
* The extension `https://num-compass.science/fhir/StructureDefinition/CompassGeccoItem` identifies the item in the logical reference model.
* The `item.definition` element contains the url of the mapped profile.

# NUMCompassIG
This is the implementation guide for the FHIR Questionnaires used by the reference app framework developed in [NUM Compass](https://num-compass.science/de/). It is based on the as-is state and supported features of the [native app](https://github.com/NUMde/compass-numapp-frontend) (developed by IBM) with additional documentation of the [GECCO](https://simplifier.net/ForschungsnetzCovid-19/) resource mapping extensions.

## Important constraints on the FHIR Questionnaire 
* Only JSON format is supported.
* The `Questionnaire.item` properties: `readOnly`, `answerValueSet` and `prefix` are not supported.
* `Questionnaire.item.repeats` is not supported for any `Questionnaire.item.type` other than `choice`. In case of `type = 'choice'` and `repeats = true`, a multiple choice list should be rendered.
* The `Questionnaire.item.type` quantity, dateTime, time, reference, attachment, openChoice is not supported. //TODO: Add constraint to the profile
* The first level of items must be of type "group"
* `Questionnaire.item.answerOption.value` must be either string or integer.
* `Questionnaire.item.enableWhen` is only permitted in combination with the equals-operator.

For more information on how the IBM reference app handles the Questionnaire resource, see the [frontend documentation of the reference app](https://github.com/NUMde/compass-numapp-frontend/tree/main/docs/questionnaireRendering).

## Supported extensions
* http://hl7.org/fhir/R4/extension-questionnaire-itemcontrol.html ("slider" only)
* https://num-compass.science/fhir/StructureDefinition/LowRangeLabel
* https://num-compass.science/fhir/StructureDefinition/HighRangeLabel
* http://hl7.org/fhir/StructureDefinition/questionnaire-sliderStepValue
* http://hl7.org/fhir/StructureDefinition/minValue
* http://hl7.org/fhir/StructureDefinition/maxValue

## Questionnaire.item-IDs 
* Because of the architecture of the IBM app, `linkId` must be of format "1.2.3" and determine order in Questionnaire. The parent's linkId must be a prefix of the child's linkId. It should be assigned automatically by the questionnaire editor.
* Because we can not choose the linkId freely, the extension `https://num-compass.science/fhir/StructureDefinition/CompassInterversionId` can be used to identify items across different versions.

In case of GECCO-Elements, there should some additional IDs be present:
* The extension `https://num-compass.science/fhir/StructureDefinition/CompassGeccoItem` identifies the item in the logical reference model.
* The `item.definition` element contains the url of the mapped profile.


## Questionnaire-IDs and Versioning
Besides the technical identifiers, which are stored in `Questionnaire.id` and `Questionnaire.identifier`, there is another "world-wide unique" identifier per Questionnaire, called `Questionnaire.url`. Often, the metadata (Questionnaire) is changed during the data capturing process. Therefore, FHIR provides the `Questionnaire.version` field to version metadata. Please note that this version is different from `Questionnaire.meta.versionId`, which corresponds to the FHIR repositories internal versioning.

The QuestionnaireResponse references its corresponding Questionnaire by `QuestionnaireResponse.questionnaire`, which is a canonical url. Its value MUST correspond to `Questionnaire.url`. The FHIR standard allows appending the version to a canonical url by seperating it with a pipe (`|`) character. If you follow this implementation guide, `QuestionnaireResponse.questionnaire` should always contain also `Questionnaire.version`.


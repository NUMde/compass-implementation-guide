# NUMCompassIG

This is the implementation guide for the FHIR Questionnaires used by the reference app framework developed in [NUM Compass](https://num-compass.science/de/), as well as the associated conformance testing frameworks for apps based on such questionnaires. It is based on the as-is state and supported features of the [native app](https://github.com/NUMde/compass-numapp-frontend) (developed by IBM) with additional documentation of the [GECCO](https://simplifier.net/ForschungsnetzCovid-19/) resource mapping extensions.

## Using Questionnaires in NUM-COMPASS
### Important constraints on the FHIR Questionnaire 

* Only JSON format is supported.
* `Questionnaire.url` and `Questionnaire.version` may not be empty. 
* The `Questionnaire.item` properties: `readOnly`, `answerValueSet` and `prefix` are not supported.
* `Questionnaire.item.repeats` is not supported for any `Questionnaire.item.type` other than `choice`. In case of `type = 'choice'` and `repeats = true`, a multiple choice list should be rendered.
* The `Questionnaire.item.type` `quantity`, `dateTime`, `time`, `reference`, `attachment`, `openChoice` are not supported.
* The first level of items must be of type "group"
* `Questionnaire.item.answerOption.value` must be either `string`, `integer` or `Coding`.
* `Questionnaire.item.enableWhen` is only permitted in combination with the equals-operator.

For more information on how the IBM reference app handles the Questionnaire resource, see the [frontend documentation of the reference app](https://github.com/NUMde/compass-numapp-frontend/tree/main/docs/questionnaireRendering).

### Additional hint:
* The item.type "choice" requires the item.answerOption-list to be of type "Coding". To create lists of strings or integers the user can choose from, use type = "string" or type = "integer" and a answerOption-list with valueString or valueInteger. See the discussion here: https://chat.fhir.org/#narrow/stream/179255-questionnaire/topic/type.3Dchoice.20and.20answerOption.2EvalueInteger.3F

### Supported extensions
* http://hl7.org/fhir/R4/extension-questionnaire-itemcontrol.html ("slider" and "dropdown" only)
* https://num-compass.science/fhir/StructureDefinition/LowRangeLabel
* https://num-compass.science/fhir/StructureDefinition/HighRangeLabel
* http://hl7.org/fhir/StructureDefinition/questionnaire-sliderStepValue
* http://hl7.org/fhir/StructureDefinition/minValue
* http://hl7.org/fhir/StructureDefinition/maxValue
* https://num-compass.science/fhir/StructureDefinition/CompassInterversionId
* https://num-compass.science/fhir/StructureDefinition/CompassGeccoItem
* https://num-compass.science/fhir/StructureDefinition/CompassTargetProfile


### Questionnaire.item-IDs 

* Because of the architecture of the IBM app, `linkId` must be of format "1.2.3" and determine order in Questionnaire. The parent's linkId must be a prefix of the child's linkId. It should be assigned automatically by the questionnaire editor.
* Because we can not choose the linkId freely, the extension `https://num-compass.science/fhir/StructureDefinition/CompassInterversionId` can be used to identify items across different versions.

In case of GECCO-Elements, some additional extensions should be present on the corresponding Questionnaire item:

* The extension `https://num-compass.science/fhir/StructureDefinition/CompassGeccoItem` identifies the item in the logical reference model.
* The extension `https://num-compass.science/fhir/StructureDefinition/CompassTargetProfile` identifies the GECCO FHIR profile that applies to the resource created by mapping from this element. Multiple instances of this extension can be included if a given element is mapped to multiple resources conforming to different GECCO profiles.


### Questionnaire-IDs and Versioning

Besides the technical identifiers, which are stored in `Questionnaire.id` and `Questionnaire.identifier`, there is another "world-wide unique" identifier per Questionnaire, called `Questionnaire.url`. Often, the structure of the captured data (as described in the Questionnaire) is changed during the data capturing process. Therefore, FHIR provides the `Questionnaire.version` field to version the Questionnaire. Please note that this version is different from `Questionnaire.meta.versionId`, which corresponds to the FHIR repositories internal versioning.

The QuestionnaireResponse references its corresponding Questionnaire by `QuestionnaireResponse.questionnaire`, which is a [canonical url](https://www.hl7.org/fhir/r4/references.html#canonical). The FHIR standard allows appending the version to a canonical url by seperating it with a pipe (`|`) character. 

Even though the FHIR specification allows falling back to a local identifier, in this implementation guide, its `QuestionnaireResponse.questionnaire` MUST correspond to `Questionnaire.url`. Implementers following this implementation guide MUST put the `Questionnaire.url` with the appended `Questionnaire.version`.

## Conformance testing

The conformance testing system is used to evaluate if test data generated by an app conforms to the GECCO standard.

### Full conformance test operation

The conformance testing operation checks a set of test data generated by an app against the GECCO standard. This operation is formally defined in the OperationDefinition resource with the canonical URL `https://num-compass.science/fhir/OperationDefinition/test-gecco-conformance`. It can be triggered by a POST request to the following URL (with the input in the message body):

```
[base URL]/$test-gecco-conformance
```

This IG contains profiles outlining the structure of the input and output for the conformance test HTTP endpoint. Below, we give high-level introductions to these formats. Users wishing to send their own data to the endpoint should consult the profiles themselves for the details and the provided example of valid input.

#### Input

The input to the conformance testing is a [FHIR Document](https://www.hl7.org/fhir/r4/documents.html), i.e. a FHIR [Bundle](https://www.hl7.org/fhir/r4/bundle.html) of type "document" in which the first element is a [Composition resource](https://www.hl7.org/fhir/r4/composition.html). The subsequent Bundle entries are resources indicating the name and publisher of the app to be tested, as well the set of resources to be tested for GECCO conformance. If the app uses one or more FHIR Questionnaires designed according to this IG for collecting data, the Bundle should also include these Questionnaire resources and link in from the appropriate section of the Composition resource. If the app creates GECCO resources directly without using Questionnaires resources, no Questionnaires must be submitted.

The exact requirements for the Bundle and the included data is captured by the corresponding profiles in this IG:

* Bundle profile: `https://num-compass.science/fhir/StructureDefinition/NumConformanceTestBundle`
* Composition profile: `https://num-compass.science/fhir/StructureDefinition/NumConformanceTestComposition`
* Profile for Device resource giving details about the app: `https://num-compass.science/fhir/StructureDefinition/NumConformanceDevice`
* Profile for Organization resource giving details about organization publishing the app: `https://num-compass.science/fhir/StructureDefinition/NumConformanceOrganization`

The central part of the Bundle is a set of FHIR resources generated by the app and linked from the appropriate section of the Composition resource. These resources must all declare a profile from the GECCO standard in the `meta.profile` element, i.e. a profile whose canonical URL starts with the GECCO base URL `https://www.netzwerk-universitaetsmedizin.de/fhir/`. Test resources that are not covered by the GECCO standard (no appropriate GECCO profile available) should only be included as if they are referred to, directly or indirectly, by a test resource with a GECCO profile. For instance. an Observation resource conforming to, say, the [GECCO blood pressure profile](https://simplifier.net/forschungsnetzcovid-19/bloodpressure) may refer to a Practitioner resource, for which there is no GECCO profile. Such a Practitioner resource can then be included in the Bundle along with the Observation referring to it, but should not be linked from the Composition.

The set of test resources should represent the full breath of resource types and relevant GECCO profiles that the app can output. If Questionnaires used by the app were submitted, they will be used to check whether the set of test data covers all the GECCO profiles declared as mapping targets in the Questionnaires. Specifically, all the GECCO profiles declared using the GECCO target profile extension (Canonical URL: `https://num-compass.science/fhir/StructureDefinition/GeccoTargetProfile`) will be collected and it will be checked that at least one test resource is supplied for each profile.

_As mentioned above, the test resource **cannot** be QuestionnaireResponse resources. If the app collects data in the form of QuestionnaireResponse resources, they must first be mapped to resources covered by the GECCO standard before being used for conformance testing._

#### Output

The return value from the conformance test HTTP endpoint depends on whether the test passed or not. A test is considered passed if and only if

1. all required data (app, publishing organization, test data) was correctly submitted AND
2. all test data resources linked directly from the Composition declare a GECCO profile, AND
3. all test data resources conform to the declared GECCO profiles, AND
4. (if Questionnaires were submitted) the test data set includes examples of all GECCO profiles declared in the Questionnaires using the GECCO target profile extension

The GECCO artifacts used for validation are those in [the `de.gecco` FHIR package](https://simplifier.net/packages/de.gecco).

### Output

The output returned by the endpoint depends on whether the test was passed or not.

* _Conformance test passed:_ PDF document documenting the successful test.
* _Conformance test failed:_ FHIR [OperationOutcome resource](https://www.hl7.org/fhir/r4/operationoutcome.html) giving result of the validation process, including the errors found.

### Further FHIR operations

Two further REST operations available as part of the conformance check service are defined

* Validate a single resource of arbitrary type: `https://num-compass.science/fhir/OperationDefinition/validate-single`
* List all resources used for validation: `https://num-compass.science/fhir/OperationDefinition/list-conformance-resources`

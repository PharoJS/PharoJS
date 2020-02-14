"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoJsExporter,
	#superclass : #PackageManifest,
	#category : #'PharoJsExporter-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoJsExporter class >> ruleGRGuradGuardClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PjDependentTranspiler #addClassToConvert: #false)) #'2020-02-14T08:19:48.428313-05:00') )
]

{ #category : #'code-critics' }
ManifestPharoJsExporter class >> ruleRBGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PjDependentTranspiler #addClassToConvert: #false)) #'2020-02-14T08:19:35.789312-05:00') )
]

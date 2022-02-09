"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoJsBaseExporter,
	#superclass : #PackageManifest,
	#category : #'PharoJs-Base-Exporter-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoJsBaseExporter class >> ruleGRGuradGuardClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PjDependentTranspiler #addClassToConvert: #false)) #'2020-02-14T08:19:48.428313-05:00') )
]

{ #category : #'code-critics' }
ManifestPharoJsBaseExporter class >> ruleRBGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PjDependentTranspiler #addClassToConvert: #false)) #'2020-02-14T08:19:35.789312-05:00') )
]

{ #category : #'code-critics' }
ManifestPharoJsBaseExporter class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PjFileExporter #createFileNamed:startingWith:and:ifEditableDo: #false)) #'2020-03-24T09:25:20.198093-04:00') )
]

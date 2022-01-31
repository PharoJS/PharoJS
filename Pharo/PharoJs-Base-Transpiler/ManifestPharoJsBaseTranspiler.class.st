"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoJsBaseTranspiler,
	#superclass : #PackageManifest,
	#category : #'PharoJs-Base-Transpiler-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoJsBaseTranspiler class >> ruleRBCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PjTranspiler #poolReference:for: #false)) #'2020-01-27T08:49:48.799166-05:00') )
]

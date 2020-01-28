"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoJsTranspiler,
	#superclass : #PackageManifest,
	#category : #'PharoJsTranspiler-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoJsTranspiler class >> ruleRBCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PjTranspiler #poolReference:for: #false)) #'2020-01-27T08:49:48.799166-05:00') )
]

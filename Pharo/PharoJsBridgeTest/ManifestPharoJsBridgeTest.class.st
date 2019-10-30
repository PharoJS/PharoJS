"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoJsBridgeTest,
	#superclass : #PackageManifest,
	#category : #'PharoJsBridgeTest-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoJsBridgeTest class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#PjBasicTest)) #'2019-10-18T16:58:01.056766-04:00') )
]

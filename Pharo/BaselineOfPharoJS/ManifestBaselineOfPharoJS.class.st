"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestBaselineOfPharoJS,
	#superclass : #PackageManifest,
	#category : #'BaselineOfPharoJS-Manifest'
}

{ #category : #'code-critics' }
ManifestBaselineOfPharoJS class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#BaselineOfPharoJS)) #'2020-02-14T19:08:56.237579-05:00') )
]

{ #category : #'code-critics' }
ManifestBaselineOfPharoJS class >> ruleRBUtilityMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#BaselineOfPharoJS)) #'2020-02-14T19:09:03.794682-05:00') )
]

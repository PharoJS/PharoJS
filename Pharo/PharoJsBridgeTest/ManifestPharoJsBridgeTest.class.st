"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoJsBridgeTest,
	#superclass : #PackageManifest,
	#category : #'PharoJsBridgeTest-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoJsBridgeTest class >> ruleRBEqualNilRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'PjLoadForTest class' #initialize #true)) #'2020-01-28T09:11:41.906215-05:00') )
]

{ #category : #'code-critics' }
ManifestPharoJsBridgeTest class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#PjBasicTest)) #'2019-10-18T16:58:01.056766-04:00') )
]

{ #category : #'code-critics' }
ManifestPharoJsBridgeTest class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'PjLoadForTest class' #initialize #true)) #'2020-01-28T09:11:47.308527-05:00') )
]

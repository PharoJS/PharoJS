"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoJsCoreLibrariesTest,
	#superclass : #PackageManifest,
	#category : #'PharoJsCoreLibrariesTest-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoJsCoreLibrariesTest class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#PjDictionaryTest)) #'2020-04-07T13:17:55.236525-04:00') )
]

{ #category : #'code-critics' }
ManifestPharoJsCoreLibrariesTest class >> ruleRBkeysDoRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PjDictionaryTest #testKeysAndValuesDo #false)) #'2020-04-30T00:35:25.536759-04:00') )
]

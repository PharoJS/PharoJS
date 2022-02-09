"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoJsBaseTranspilerOptimizations,
	#superclass : #PackageManifest,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoJsBaseTranspilerOptimizations class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PjConversionOptimizationTest #testBlockReturns #false)) #'2020-03-31T21:57:36.931316-04:00') #(#(#RGMethodDefinition #(#PjConversionOptimizationTest #testBlockReturns1 #false)) #'2020-03-31T22:18:03.661616-04:00') )
]

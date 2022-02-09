"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoJsBaseBridge,
	#superclass : #PackageManifest,
	#category : #'PharoJs-Base-Bridge-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoJsBaseBridge class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PjBridge #timeout: #false)) #'2022-02-02T08:50:25.026526+01:00') )
]

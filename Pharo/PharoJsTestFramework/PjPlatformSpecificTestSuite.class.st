Class {
	#name : #PjPlatformSpecificTestSuite,
	#superclass : #TestSuite,
	#instVars : [
		'targetPlatform'
	],
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #accessing }
PjPlatformSpecificTestSuite >> resources [
	^ super resources copyWith: self targetPlatform 
]

{ #category : #running }
PjPlatformSpecificTestSuite >> run: aResult [
	self tests do: [ : each | each targetPlatform: self targetPlatform ].
	super run: aResult. 
]

{ #category : #accessing }
PjPlatformSpecificTestSuite >> targetPlatform [
	^ targetPlatform
]

{ #category : #accessing }
PjPlatformSpecificTestSuite >> targetPlatform: aResource [
	targetPlatform := aResource.
	self tests do: [ : each | each targetPlatform: aResource ].
	self name: self name, aResource name capitalized.

]

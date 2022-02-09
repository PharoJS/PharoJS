"
I am the Javascript embodiment of Magnitude.
"
Class {
	#name : #PjMagnitude,
	#superclass : #PjObject,
	#traits : 'PjTMagnitude',
	#classTraits : 'PjTMagnitude classTrait',
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'pharojs support' }
PjMagnitude class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^ self jsTranspilationImportMethodsMagnitude
]

{ #category : #testing }
PjMagnitude >> < aMagnitude [
	^self subclassResponsibility
]

{ #category : #testing }
PjMagnitude >> = aMagnitude [
	^self subclassResponsibility
]

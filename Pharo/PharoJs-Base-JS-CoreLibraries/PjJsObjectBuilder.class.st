Class {
	#name : #PjJsObjectBuilder,
	#superclass : #Object,
	#instVars : [
		'convertedObjects'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #converting }
PjJsObjectBuilder class >> convert: anObject [
	^self new convert: anObject
]

{ #category : #converting }
PjJsObjectBuilder >> convert: anObject [
	| jsObject |
	convertedObjects at: anObject ifPresent: [: cachedJsObject | ^cachedJsObject].
	jsObject := anObject asJsObjectUsing: self.
	convertedObjects at: anObject put: jsObject.
	^jsObject
]

{ #category : #'initialize-release' }
PjJsObjectBuilder >> initialize [
	super initialize.
	convertedObjects := Dictionary new
]

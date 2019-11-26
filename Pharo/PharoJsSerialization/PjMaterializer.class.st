Class {
	#name : #PjMaterializer,
	#superclass : #Object,
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsSerialization-Kernel'
}

{ #category : #materializing }
PjMaterializer class >> materializeFromArray: aString [
	^self new materializeFromArray: aString
]

{ #category : #materializing }
PjMaterializer class >> materializeFromString: aString [
	^self new materializeFromString: aString
]

{ #category : #materializing }
PjMaterializer >> materializeFromArray: serializedObjects [
	| class materializedObjects |
	materializedObjects := serializedObjects
		collect: [ :array | 
			class := Smalltalk at: array first asSymbol.
			class newFromMaterialized: array second ].
	^ materializedObjects
]

{ #category : #materializing }
PjMaterializer >> materializeFromString: aString [
	| serializedObjects |
	serializedObjects := JSON parse: aString.
	^self materializeFromArray: serializedObjects
]

Class {
	#name : #PjMaterializer,
	#superclass : #Object,
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsSerialization-Kernel'
}

{ #category : #materializing }
PjMaterializer class >> materializeFrom: aString [
	^self new materializeFrom: aString
]

{ #category : #materializing }
PjMaterializer >> materializeFrom: aString [
	| serializedObjects class materializedObjects |
	serializedObjects := JSON parse: aString.
	materializedObjects := serializedObjects collect: [ : array |
		class := Smalltalk at: array first.
		class newFromMaterialized: array second
	].
	^materializedObjects first
]

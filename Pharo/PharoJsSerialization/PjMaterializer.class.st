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
		class := window instVarNamed: array first.
console log: 'materializationArray: '.
console log: array second.
		class newFromMaterialized: array second
	].
console log: 'Materialized objects:'.
console log: materializedObjects.
	materializedObjects do: [ : each | each initAfterMaterializationWith: materializedObjects ].
	^materializedObjects first
]

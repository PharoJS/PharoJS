Class {
	#name : #PjMaterializer,
	#superclass : #Object,
	#instVars : [
		'materializedObjects',
		'initObjects'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsSerialization-Kernel'
}

{ #category : #materializing }
PjMaterializer class >> materializeFromArray: anArray [
	^self new materializeFromArray: anArray
]

{ #category : #materializing }
PjMaterializer class >> materializeFromString: aString [
	^self new materializeFromString: aString
]

{ #category : #accessing }
PjMaterializer >> materializationAt: index [
	^materializedObjects at: index
]

{ #category : #materializing }
PjMaterializer >> materializeFromArray: objectDescriptions [
	materializedObjects := OrderedCollection new.
	initObjects := OrderedCollection new.
	objectDescriptions do: [ : each | self newFromArray: each].
	materializedObjects with: initObjects do: [ : materialization : contentsDescription | 
		materialization materializer: self initWith: contentsDescription
	].
	^materializedObjects first
]

{ #category : #materializing }
PjMaterializer >> materializeFromString: aString [
	| serializedObjects |
	serializedObjects := JSON parse: aString.
	^self materializeFromArray: serializedObjects
]

{ #category : #materializing }
PjMaterializer >> newFromArray: serializationDescription [
	| class materializationContents materialization |
	class := Smalltalk at: serializationDescription first asSymbol.
	materializationContents := serializationDescription second.
	materialization := class materializeWith: self contents: materializationContents.
	materializedObjects addLast: materialization.
	initObjects addLast: materializationContents.
	^materialization
]

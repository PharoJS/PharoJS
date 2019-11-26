Class {
	#name : #PjMaterializerOLD,
	#superclass : #Object,
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsSerialization-Kernel'
}

{ #category : #materializing }
PjMaterializerOLD class >> materializeFrom: anObject [
	^anObject materialize
]

{ #category : #materializing }
PjMaterializerOLD class >> materializeFromArray: array [
	| class |
	class := window instVarNamed: array first.
	^ class newFromMaterialized: array second
]

{ #category : #materializing }
PjMaterializerOLD class >> materializeFromString: aString [
	| array |
	array := JSON parse: aString.
	^self materializeFromArray: array
]

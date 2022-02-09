Class {
	#name : #PjMaterializer,
	#superclass : #Object,
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJs-Base-Serialization-Deprecated-Kernel'
}

{ #category : #materializing }
PjMaterializer class >> materializeFrom: anObject [
	^anObject materialize
]

{ #category : #materializing }
PjMaterializer class >> materializeFromArray: array [
	| class |
	class := window instVarNamed: array first.
	^class newFromMaterialized: array second
]

{ #category : #materializing }
PjMaterializer class >> materializeFromString: aString [
	| array |
	array := JSON parse: aString.
	^self materializeFromArray: array
]

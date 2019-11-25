Class {
	#name : #PjSerializationTestSupport,
	#superclass : #Object,
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsSerialization-Tests'
}

{ #category : #serializing }
PjSerializationTestSupport >> assertCollection: aCollection [
	| clone |
	clone := self serializeThenMaterialize: aCollection.
	clone class == aCollection class ifFalse: [ ^false ].
	clone size == aCollection size ifFalse: [ ^false ].
	aCollection withIndexDo: [ : element : index |
		element class == (clone at: index) class ifFalse: [ ^false ].
	].
	^true
]

{ #category : #serializing }
PjSerializationTestSupport >> assertComplexObject: aComposite [
	| clone |
	clone := self serializeThenMaterialize: aComposite.
	clone class == aComposite class ifFalse: [ ^false ].
	clone a class == aComposite a class ifFalse: [ ^false ].
	clone b class == aComposite b class ifFalse: [ ^false ].
	^true
]

{ #category : #serializing }
PjSerializationTestSupport >> assertDuration: aDuration [
	| clone |
	clone := self serializeThenMaterialize: aDuration.
	clone class == Duration ifFalse: [ ^false ].
	^aDuration totalSeconds = clone totalSeconds
]

{ #category : #serializing }
PjSerializationTestSupport >> assertEquals: anObject [
	^(self serializeThenMaterialize: anObject) = anObject
]

{ #category : #serializing }
PjSerializationTestSupport >> assertIdentity: anObject [
	^(self serializeThenMaterialize: anObject) == anObject
]

{ #category : #serializing }
PjSerializationTestSupport >> assertTime: aTime [
	| clone |
	clone := self serializeThenMaterialize: aTime.
	clone class == Time ifFalse: [ ^false ].
	clone hour24 = aTime hour24 ifFalse: [ ^false ].
	clone minute = aTime minute ifFalse: [ ^false ].
	clone second = aTime second ifFalse: [ ^false ].
	^true
]

{ #category : #serializing }
PjSerializationTestSupport >> logOriginal: original clone: clone [
	console log: '---'.
	console log: 'serializing: '.
	console log: original.
	console log: 'materializing: '.
	console log: clone.
	console log: '---'
]

{ #category : #serializing }
PjSerializationTestSupport >> serializeThenMaterialize: anObject [
	| clone |
	clone := PjMaterializer materializeFrom: anObject serialize.
	self logOriginal: anObject clone: clone.
	^clone

]

Class {
	#name : #PjSerializationTestSupport,
	#superclass : #Object,
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsSerialization-Tests'
}

{ #category : #serializing }
PjSerializationTestSupport class >> assertCollection: aCollection [
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
PjSerializationTestSupport class >> assertComplexObject: aComposite [
	| clone |
	clone := self serializeThenMaterialize: aComposite.
	clone class == aComposite class ifFalse: [ ^false ].
	clone a class == aComposite a class ifFalse: [ ^false ].
	clone b class == aComposite b class ifFalse: [ ^false ].
	^true
]

{ #category : #serializing }
PjSerializationTestSupport class >> assertDuration: aDuration [
	| clone |
	clone := self serializeThenMaterialize: aDuration.
	clone class == Duration ifFalse: [ ^false ].
	^aDuration totalSeconds = clone totalSeconds
]

{ #category : #serializing }
PjSerializationTestSupport class >> assertEquals: anObject [
	^(self serializeThenMaterialize: anObject) = anObject
]

{ #category : #serializing }
PjSerializationTestSupport class >> assertIdentity: anObject [
	^(self serializeThenMaterialize: anObject) == anObject
]

{ #category : #serializing }
PjSerializationTestSupport class >> assertTime: aTime [
	| clone |
	clone := self serializeThenMaterialize: aTime.
	clone class == Time ifFalse: [ ^false ].
	clone hour24 = aTime hour24 ifFalse: [ ^false ].
	clone minute = aTime minute ifFalse: [ ^false ].
	clone second = aTime second ifFalse: [ ^false ].
	^true
]

{ #category : #serializing }
PjSerializationTestSupport class >> serializeThenMaterialize: anObject [
	^PjMaterializer materializeFrom: anObject serialize
]

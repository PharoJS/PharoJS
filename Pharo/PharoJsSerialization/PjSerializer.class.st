Class {
	#name : #PjSerializer,
	#superclass : #Object,
	#instVars : [
		'serializationArray',
		'serializedObjects'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsSerialization-Kernel'
}

{ #category : #serializing }
PjSerializer class >> serialize: anObject [
	^self new serialize: anObject
]

{ #category : #serializing }
PjSerializer >> serializationIndexFor: anObject [
	(serializedObjects includes: anObject) ifFalse: [
		serializedObjects addLast: anObject.
		anObject jsonSerializeWith: self.
	].
	^serializedObjects indexOf: anObject
]

{ #category : #serializing }
PjSerializer >> serialize: anObject [
	serializedObjects := OrderedCollection with: anObject.
	serializationArray := OrderedCollection new.
	anObject jsonSerializeWith: self.
	^serializationArray asJSON

]

{ #category : #serializing }
PjSerializer >> serializeArray: anArray [
	| contentIndices valueIndex |
	serializedObjects add: anArray.
	contentIndices := OrderedCollection new.
	serializationArray add: {anArray className. contentIndices}.
	anArray do: [ : each | 
		valueIndex := self serializationIndexFor: each.
		contentIndices addLast: valueIndex
	].

]

{ #category : #serializing }
PjSerializer >> serializeLiteral: aLiteral [
	serializationArray add: {'PjSerializedLiteral'. aLiteral}
]

{ #category : #serializing }
PjSerializer >> serializeNil [
	serializationArray add: {'PjUndefined'. nil}	
]

{ #category : #serializing }
PjSerializer >> serializeObject: anObject [
	|contentsDict valueIndex |
	contentsDict := Dictionary new.
	anObject keysAndValuesDo: [ : key : value |
		value ifNotNil: [
			valueIndex := self serializationIndexFor: value.
			contentsDict at: key put: valueIndex
		]
	].
	serializationArray add: {anObject className. contentsDict}
]

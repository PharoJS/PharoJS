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
PjSerializer class >> serializationArrayFrom: anObject [
	^self new serializationArrayFrom: anObject
]

{ #category : #serializing }
PjSerializer class >> serialize: anObject [
	^self new serialize: anObject
]

{ #category : #serializing }
PjSerializer >> dateClass [
	^DateAndTime
]

{ #category : #serializing }
PjSerializer >> serializationArrayFrom: anObject [
	serializedObjects := OrderedCollection with: anObject.
	serializationArray := OrderedCollection new.
	anObject jsonSerializeWith: self.
	^serializationArray asArray

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
PjSerializer >> serializationString [
	^ serializationArray asJSON
]

{ #category : #serializing }
PjSerializer >> serialize: anObject [
	self serializationArrayFrom: anObject.
	^self serializationString
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
PjSerializer >> serializeDateOrTime: aDate [
	serializationArray add: {self dateClass name. aDate}
]

{ #category : #serializing }
PjSerializer >> serializeLiteral: aLiteral [
	serializationArray add: {self serializedLiteralClass name. aLiteral}
]

{ #category : #serializing }
PjSerializer >> serializeNil [
	serializationArray add: {self serializedLiteralClass name. nil}	
]

{ #category : #serializing }
PjSerializer >> serializeObject: anObject [
	|contentsDict |
	contentsDict := Dictionary new.
	anObject notNilIvNamesAndValuesDo: [ : key : value |
		contentsDict at: key put: value
	].
	serializationArray add: {anObject className. contentsDict}
]

{ #category : #serializing }
PjSerializer >> serializedLiteralClass [
	^PjSerializedLiteral
]

Class {
	#name : #PjSerializer,
	#superclass : #Object,
	#instVars : [
		'serializedObjects',
		'serializations'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsSerialization-Kernel'
}

{ #category : #serializing }
PjSerializer class >> serializationArrayFor: anObject [
	^self new serializationArrayFor: anObject
]

{ #category : #serializing }
PjSerializer class >> serialize: anObject [
	^self new serialize: anObject
]

{ #category : #serializing }
PjSerializer >> dateClass [
	^DateAndTime
]

{ #category : #initialization }
PjSerializer >> initialize [
	super initialize.
	serializedObjects := OrderedCollection new.
	serializations := OrderedCollection new.
]

{ #category : #serializing }
PjSerializer >> newSerializationIndexFor: anObject [
	| objectIndex partialSerialization |
	serializedObjects addLast: anObject.
	objectIndex := serializedObjects size.
	serializations addLast: nil. "Save position"
	partialSerialization := anObject jsonSerializeWith: self.
	serializations at: objectIndex put: partialSerialization.
	^objectIndex
	
]

{ #category : #serializing }
PjSerializer >> serializationArrayFor: anObject [
	self newSerializationIndexFor: anObject.
	^serializations asArray	
]

{ #category : #serializing }
PjSerializer >> serializationIndexFor: anObject [
	^serializedObjects 
		indexOf: anObject 
		ifAbsent: [ self newSerializationIndexFor: anObject ]
]

{ #category : #serializing }
PjSerializer >> serialize: anObject [
	| serialization |
	serialization := self serializationArrayFor: anObject.
	^serialization asJSON
]

{ #category : #serializing }
PjSerializer >> serializeArray: anArray [
	| serializedContent |
	serializedContent := anArray collect: [ : each | 
		self serializationIndexFor: each.
	].
	^{anArray className. serializedContent asArray}.

]

{ #category : #serializing }
PjSerializer >> serializeDateOrTime: aDate [
	^{self dateClass name. aDate}
]

{ #category : #serializing }
PjSerializer >> serializeLiteral: aLiteral [
	^{self serializedLiteralClass name. aLiteral}
]

{ #category : #serializing }
PjSerializer >> serializeObject: anObject [
	|contentsDict|
	contentsDict := Dictionary new.
	anObject notNilIvNamesAndValuesDo: [ : key : value |
		contentsDict at: key put: value
	].
	^{anObject className. contentsDict}.

]

{ #category : #serializing }
PjSerializer >> serializedLiteralClass [
	^PjSerializedLiteral
]

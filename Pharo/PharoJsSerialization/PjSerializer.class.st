Class {
	#name : #PjSerializer,
	#superclass : #Object,
	#instVars : [
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

{ #category : #initialization }
PjSerializer >> initialize [
	super initialize.
	serializedObjects := OrderedCollection new
]

{ #category : #serializing }
PjSerializer >> serializationArrayFrom: anObject [
	serializedObjects addLast: anObject.
	^anObject jsonSerializeWith: self.

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
	| serialization |
	serialization := self serializationArrayFrom: anObject.
	^serialization asJSON
]

{ #category : #serializing }
PjSerializer >> serializeArray: anArray [
	| serializedContent serializedElement |
	serializedObjects add: anArray.
	serializedContent := OrderedCollection new.
	anArray do: [ : each | 
		serializedElement := self serialize: each.
		serializedContent addLast: serializedElement
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

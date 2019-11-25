Class {
	#name : #PjSerializationTest,
	#superclass : #PjWebAppTestCase,
	#instVars : [
		'serializerClass',
		'materializerClass'
	],
	#category : #'PharoJsSerialization-Tests'
}

{ #category : #'suite parameters' }
PjSerializationTest class >> appClass [
	^PjMinimalApp
]

{ #category : #tests }
PjSerializationTest >> assertSerialize: anObject equals: expectedString [
	| actualString |
	actualString := serializerClass serialize: anObject.
	self assert: actualString equals: expectedString
]

{ #category : #tests }
PjSerializationTest >> assertSerializeMaterialize: anObject [
	| jsonString clone |
	jsonString := serializerClass serialize: anObject.
	clone := materializerClass materializeFrom: jsonString.
	self assert: clone equals: anObject
]

{ #category : #testing }
PjSerializationTest >> materializerClass [
	^PjMaterializer
]

{ #category : #tests }
PjSerializationTest >> nilJsonSerialized [
	^'["PjUndefined",undefined]'
]

{ #category : #testing }
PjSerializationTest >> serializerClass [
	^PjSerializer
]

{ #category : #testing }
PjSerializationTest >> setUp [
	super setUp.
	materializerClass := self materializerClass.
	serializerClass := self serializerClass.
]

{ #category : #tests }
PjSerializationTest >> testLiteralMaterialize [
	self assertSerializeMaterialize: 1024.
	self assertSerializeMaterialize: 3.14.
	self assertSerializeMaterialize: true.
	self assertSerializeMaterialize: false.
	self assertSerializeMaterialize: nil.
	self assertSerializeMaterialize: 'hello'.
	self assertSerializeMaterialize: 'I love PharoJS'.

]

{ #category : #tests }
PjSerializationTest >> testLiteralSerialization [
	self assertSerialize: 1024 equals: '[["PjSerializedLiteral",1024]]'.
	self assertSerialize: 3.14 equals: '[["PjSerializedLiteral",3.14]]'.
	self assertSerialize: true equals: '[["PjSerializedLiteral",true]]'.
	self assertSerialize: false equals: '[["PjSerializedLiteral",false]]'.
	self assertSerialize: nil equals: '[', self nilJsonSerialized, ']'.
	self assertSerialize: 'hello' equals: '[["PjSerializedLiteral","hello"]]'.
	self assertSerialize: 'I love PharoJS' equals: '[["PjSerializedLiteral","I love PharoJS"]]'.

]

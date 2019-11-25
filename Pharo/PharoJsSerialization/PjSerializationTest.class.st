Class {
	#name : #PjSerializationTest,
	#superclass : #PjWebAppTestCase,
	#category : #'PharoJsSerialization-Tests'
}

{ #category : #'suite parameters' }
PjSerializationTest class >> appClass [
	^PjMinimalApp
]

{ #category : #tests }
PjSerializationTest >> assertSerialize: anObject equals: expectedString [
	| serializer actualString |
	serializer := self newSerializer.
	actualString := serializer serialize: anObject.
	self assert: actualString equals: expectedString
]

{ #category : #'instance creation' }
PjSerializationTest >> materializerClass [
	^PjMaterializer
]

{ #category : #'instance creation' }
PjSerializationTest >> newMaterializer [
	^self materializerClass new.
]

{ #category : #'instance creation' }
PjSerializationTest >> newSerializer [
	^self serializerClass new.
]

{ #category : #'instance creation' }
PjSerializationTest >> serializerClass [
	^PjSerializer
]

{ #category : #tests }
PjSerializationTest >> testLiteralSerialization [
	self assertSerialize: 1024 equals: '[["PjSerializedLiteral",1024]]'.
	self assertSerialize: 3.14 equals: '[["PjSerializedLiteral",3.14]]'.
	self assertSerialize: true equals: '[["PjSerializedLiteral",true]]'.
	self assertSerialize: false equals: '[["PjSerializedLiteral",false]]'.
	self assertSerialize: nil equals: '[["PjUndefined"]]'.
	self assertSerialize: 'hello' equals: '[["PjSerializedLiteral","hello"]]'.
	self assertSerialize: 'I love PharoJS' equals: '[["PjSerializedLiteral","I love PharoJS"]]'.

]

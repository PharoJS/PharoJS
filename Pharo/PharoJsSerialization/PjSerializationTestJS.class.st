Class {
	#name : #PjSerializationTestJS,
	#superclass : #PjSerializationTest,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJsSerialization-Tests'
}

{ #category : #testing }
PjSerializationTestJS class >> shouldInheritSelectors [
	^true
]

{ #category : #tests }
PjSerializationTestJS >> assertEquivalent: aBlock [
	self assert: aBlock evaluatesTo: aBlock value
]

{ #category : #tests }
PjSerializationTestJS >> assertSerialize: aBlock equals: expectedString [
	| actualString anObject |
	anObject := self evalLocally: aBlock.
	actualString := serializerClass serialize: anObject.
	self assert: actualString equals: expectedString
]

{ #category : #tests }
PjSerializationTestJS >> evalLocally: aBlock [
	^self evalBlock: aBlock
]

{ #category : #'instance creation' }
PjSerializationTestJS >> materializerClass [
	^self bridge evalBlock: [PjMaterializer]

]

{ #category : #tests }
PjSerializationTestJS >> nilJsonSerialized [
	^'["PjSerializedLiteral",null]'
]

{ #category : #tests }
PjSerializationTestJS >> serializeThenMaterialize: anObject [
	| serializationString |
	serializationString := serializerClass
		serialize: anObject.
	^ materializerClass materializeFromString: serializationString
]

{ #category : #'instance creation' }
PjSerializationTestJS >> serializerClass [
	^self bridge evalBlock: [PjSerializer]

]

{ #category : #tests }
PjSerializationTestJS >> testLiteralSerialization [
	self assertSerialize: [1024] equals: '[["PjSerializedLiteral",1024]]'.
	self assertSerialize: [3.14] equals: '[["PjSerializedLiteral",3.14]]'.
	self assertSerialize: [true] equals: '[["PjSerializedLiteral",true]]'.
	self assertSerialize: [false] equals: '[["PjSerializedLiteral",false]]'.
	self assertSerialize: [nil] equals: '[["PjSerializedLiteral",null]]'.
	self assertSerialize: ['hello'] equals: '[["PjSerializedLiteral","hello"]]'.
	self assertSerialize: ['I love PharoJS'] equals: '[["PjSerializedLiteral","I love PharoJS"]]'.

]

{ #category : #tests }
PjSerializationTestJS >> testLiteralSerializationEquivalence [
	self assertEquivalent: [1024 jsonSerialize].
	self assertEquivalent: [3.14 jsonSerialize].
	self assertEquivalent: [true jsonSerialize].
	self assertEquivalent: [false jsonSerialize].
	self assertEquivalent: ['hello' jsonSerialize].
	self assertEquivalent: ['I love PharoJS' jsonSerialize].

]

{ #category : #tests }
PjSerializationTestJS >> testSerializeArrayOfLiterals [
	self assertSerialize: [ #() ] equals: '[["Array",[]]]'.
	self 
		assertSerialize: [ #(31 12 23) ] 
		equals: '[["Array",[2,3,4]],["PjSerializedLiteral",31],["PjSerializedLiteral",12],["PjSerializedLiteral",23]]'.
	self 
		assertSerialize: [ #('abc' 'other' 'yes') ] 
		equals: '[["Array",[2,3,4]],["PjSerializedLiteral","abc"],["PjSerializedLiteral","other"],["PjSerializedLiteral","yes"]]'.
]

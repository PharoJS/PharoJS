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

{ #category : #'instance creation' }
PjSerializationTestJS >> materializerClass [
	^self bridge evalBlock: [PjMaterializer]

]

{ #category : #tests }
PjSerializationTestJS >> nilJsonSerialized [
	^'["PjUndefined",null]'
]

{ #category : #'instance creation' }
PjSerializationTestJS >> serializerClass [
	^self bridge evalBlock: [PjSerializer]

]

{ #category : #tests }
PjSerializationTestJS >> testLiteralJsonSerialization [
	self assertEquivalent: [1024 jsonSerialize].
	self assertEquivalent: [3.14 jsonSerialize].
	self assertEquivalent: [true jsonSerialize].
	self assertEquivalent: [false jsonSerialize].
	self assertEquivalent: ['hello' jsonSerialize].
	self assertEquivalent: ['I love PharoJS' jsonSerialize].

]

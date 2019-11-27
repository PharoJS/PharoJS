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
PjSerializationTest >> assert: accessors onSerializeThenMaterialize: aBlock [ 
	| clone original |
	original := self evalLocally: aBlock.
	clone := self serializeThenMaterialize: original.
	self assert: clone class == original class.
	accessors do: [ : selector |
		self assert: (clone perform: selector) equals: (original perform: selector)
	] 

]

{ #category : #tests }
PjSerializationTest >> assertDuration: aBlock [
	self assert: #(totalSeconds) onSerializeThenMaterialize: aBlock 

]

{ #category : #tests }
PjSerializationTest >> assertEqualitySerializeMaterialize: aBlock [
	| clone  anObject |
	anObject := self evalLocally: aBlock.
	clone := self serializeThenMaterialize: anObject.
	self assert: clone equals: anObject
]

{ #category : #tests }
PjSerializationTest >> assertIdentitySerializeMaterialize: aBlock [
	| clone anObject |
	anObject := self evalLocally: aBlock.
	clone := self serializeThenMaterialize: anObject.
	self assert: clone == anObject
]

{ #category : #tests }
PjSerializationTest >> assertSerializationArrayOf: originalBlock equals: expectedBlock [
	| original serializationArray expected |
	original := self evalLocally: originalBlock.
	serializationArray := serializerClass serializationArrayFor: original.
	expected := self evalLocally: expectedBlock.
	self assert: serializationArray = expected.
]

{ #category : #tests }
PjSerializationTest >> assertTime: aBlock [
	self 
		assert: #(hour24 minute second) 
		onSerializeThenMaterialize: aBlock 

]

{ #category : #tests }
PjSerializationTest >> evalLocally: aBlock [
	^aBlock value
]

{ #category : #tests }
PjSerializationTest >> materializerClass [
	^PjMaterializer
]

{ #category : #tests }
PjSerializationTest >> serializeThenMaterialize: aBlock [
	| serializationArray anObject |
	anObject := self evalLocally: aBlock.
	serializationArray := serializerClass
		serializationArrayFor: anObject.
	^ materializerClass materializeFromArray: serializationArray
]

{ #category : #tests }
PjSerializationTest >> serializerClass [
	^PjSerializer
]

{ #category : #tests }
PjSerializationTest >> setUp [
	super setUp.
	materializerClass := self materializerClass.
	serializerClass := self serializerClass.
]

{ #category : #tests }
PjSerializationTest >> testArrayCircularReferences [
	self assertEqualitySerializeMaterialize: [ |array1 array2|
		array1 := Array new: 1.
		array2 := { array1 }.
		array1 at: 1 put: array2.
		array1.].

	self assertEqualitySerializeMaterialize: [ |array|
		array := Array new: 1.
		array at: 1 put: array.
		array].

]

{ #category : #tests }
PjSerializationTest >> testArrayOfArrays [
	self assertEqualitySerializeMaterialize: [ {#()} ].
	self assertEqualitySerializeMaterialize: [ {#(). 3.14} ].
	self assertEqualitySerializeMaterialize: [ {#(31 12 23). #(). #('abc' 'other' 'yes')} ].

]

{ #category : #tests }
PjSerializationTest >> testArrayOfLiterals [
	self assertEqualitySerializeMaterialize: [ #() ].
	self assertEqualitySerializeMaterialize: [ #(31 12 23) ].
	self assertEqualitySerializeMaterialize: [ #('abc' 'other' 'yes') ].

]

{ #category : #tests }
PjSerializationTest >> testDuration [
	self assertDuration: [Duration zero].
	self assertDuration: [10 years].
	self assertDuration: [6 months].
	self assertDuration: [2 weeks].
	self assertDuration: [2 hours].
	self assertDuration: [30 minutes].
	self assertDuration: [10 seconds].

]

{ #category : #tests }
PjSerializationTest >> testLiterals [
	self assertIdentitySerializeMaterialize: [1024].
	self assertIdentitySerializeMaterialize: [3.14].
	self assertIdentitySerializeMaterialize: [true].
	self assertIdentitySerializeMaterialize: [false].
	self assertIdentitySerializeMaterialize: [nil].
	self assertEqualitySerializeMaterialize: ['hello'].
	self assertEqualitySerializeMaterialize: ['I love PharoJS'].

]

{ #category : #tests }
PjSerializationTest >> testSerializationArrayWithArrayOfLiterals [
	
	self 
		assertSerializationArrayOf: [ #() ] 
		equals: [
			{
				{#Array. #()}
			}
	].
	self 
		assertSerializationArrayOf: [ #(31 12 23) ] 
		equals: [
			{
				{#Array. #(2 3 4)}. 
				{#PjSerializedLiteral. 31}.
				{#PjSerializedLiteral. 12}.
				{#PjSerializedLiteral. 23}.
			}
		].
	self 
		assertSerializationArrayOf: [ #('abc' 'other' 'yes') ] 
		equals: [
			{
				{#Array. #(2 3 4)}. 
				{#PjSerializedLiteral. 'abc'}.
				{#PjSerializedLiteral. 'other'}.
				{#PjSerializedLiteral. 'yes'}.
			}
		].

]

{ #category : #tests }
PjSerializationTest >> testTimePart1 [
	"Test split in parts, because it takes too much time when serialization is done on JS"
	self assertTime: [Time now].
	self assertTime: [Time noon].
	self assertTime: [Time midnight].
	self assertTime: [Time now seconds: 25].
	self assertTime: [Time now seconds: 625].

]

{ #category : #tests }
PjSerializationTest >> testTimePart2 [
	"Test split in parts, because it takes too much time when serialization is done on JS"
	self assertTime: [Time hour: 1 minute: 1 second: 13].
	self assertTime: [Time hour: 1 minute: 0 second: 0].
	self assertTime: [Time hour: 12 minute: 0 second: 0].
	self assertTime: [Time hour: 13 minute: 0 second: 0].
	self assertTime: [Time hour: 23 minute: 59 second: 30].

]

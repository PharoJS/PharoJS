Class {
	#name : #PhxBridgedJsonSerialisationTests,
	#superclass : #PjBridgeTestCase,
	#category : #PharoJsSerializationTest
}

{ #category : #private }
PhxBridgedJsonSerialisationTests >> assertAllWithInstantiationBlock: aBlock literal: jsonString testEq: testEq test4Stages: test4Stages [

	| instanceProxy |
	instanceProxy := self evalBlock: aBlock.
	self
		assert: [ instanceProxy asPhxJsonString ]
		evaluatesTo: jsonString.

	testEq ifTrue: [ self assertEquivalent: aBlock ].
	self isEqualAfterWriteReadInJs: aBlock.
	test4Stages ifTrue: [ 
		self isEqualAfter4StageMarshalingInBothWorlds: aBlock ]
]

{ #category : #private }
PhxBridgedJsonSerialisationTests >> isEqualAfter4StageMarshalingInBothWorlds: aBlock [

	| jsonStringOfObject objectProxy serializedInJsWorld materializedObjectSmalltalk serializedInSmalltalkWorld stringifiedAfterMaterializedInJsWorld |
	objectProxy := self evalBlock: aBlock.
	serializedInJsWorld := self evalBlock: [ objectProxy asPhxJsonString ].
	materializedObjectSmalltalk := PhxJsonReader readFromString:
		                               serializedInJsWorld.
	serializedInSmalltalkWorld := materializedObjectSmalltalk
		                              asPhxJsonString.
	stringifiedAfterMaterializedInJsWorld := self evalBlock: [ 
		                                         JSON stringify:
			                                         (PhxJsonReader 
				                                          readFromString:
				                                          serializedInSmalltalkWorld) ].
	jsonStringOfObject := self evalBlock: [ JSON stringify: objectProxy ].
	self
		assert: stringifiedAfterMaterializedInJsWorld
		equals: jsonStringOfObject
]

{ #category : #private }
PhxBridgedJsonSerialisationTests >> isEqualAfterWriteReadInJs: aBlock [

	| jsonStringAfterWriteRead jsonStringOfObject instanceProxy instanceJsonInJsWorld |
	instanceProxy := self evalBlock: aBlock.
	instanceJsonInJsWorld := self evalBlock: [ 
		                         instanceProxy asPhxJsonString ].
	jsonStringAfterWriteRead := self evalBlock: [ 
		                            JSON stringify:
			                            (PhxJsonReader readFromString:
				                             instanceProxy asPhxJsonString) ].
	jsonStringOfObject := self evalBlock: [ 
		                      JSON stringify: instanceProxy ].
	self assert: jsonStringAfterWriteRead equals: jsonStringOfObject
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeArray [
	self
		assertAllWithInstantiationBlock:  [{}]  
		literal: '{"class":"Array","instance":[]}'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeAssociations [
	self
		assertAllWithInstantiationBlock: [{ 'een' -> 1. 'twee' -> 2 }  ]
		literal: '{"class":"Array","instance":[{"class":"Association","instance":{"key":"een","value":1}},{"class":"Association","instance":{"key":"twee","value":2}}]}'
		testEq: false
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeBoolean [
	self
		assertAllWithInstantiationBlock: [ true  ]
		literal: 'true'
		testEq: true
		test4Stages: true.
	self
		assertAllWithInstantiationBlock: [ false  ]
		literal: 'false'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeChallengingObject [
	self
		assertAllWithInstantiationBlock: [ PhxJsonTestResources challingingObjectAvoidingDateAndTime  ]
		literal: PhxJsonTestResources challingingObjectAvoidingDateAndTime asPhxJsonString
		testEq: false
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeDate [
	<expectedFailure>
	self fail: #ToDo.
	self
		assertAllWithInstantiationBlock: [ | d |
			d := (DateAndTime
				year: 2020
				month: 04
				day: 11
				hour: 23
				minute: 2
				second: 3) asDate.
			d  ]
		literal: '{"class":"DateAndTime","instance":"2020-04-11T23:02:03.000Z"}'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeDateAndTime [
	<expectedFailure>
	self fail: #ToDo.
	self
		assertAllWithInstantiationBlock: [ | d |
			d := DateAndTime
				year: 2020
				month: 04
				day: 11
				hour: 23
				minute: 2
				second: 3.
			d  ]
		literal: '{"class":"DateAndTime","instance":"2020-04-11T23:02:03.000Z"}'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeDictionary [
	self
		assertAllWithInstantiationBlock: [ | d |
			d := Dictionary new.
			d at: 'a' put: 'abc'.
			d at: 'b' put: '123'.
			d ]
		literal: '{"class":"Dictionary","instance":{"a":"abc","b":"123"}}'
		testEq: false "#assertEquivalent: doesn't work for this type of object"
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeEmptyObject [
	self
		assertAllWithInstantiationBlock: [ Object new  ]
		literal: '{"class":"Object","instance":{}}'
		testEq: false "#assertEquivalent: doesn't work for this type of object"
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeIdentityDictionary1Entry [

	self
		assertAllWithInstantiationBlock: [ 
			| d |
			d := IdentityDictionary new.
			d at: 'b' put: '123'.
			d ]
		literal: '{"class":"IdentityDictionary","instance":{"b":"123"}}'
		testEq: false "#assertEquivalent: doesn't work for this type of object"
		test4Stages: true.
	self
		assertAllWithInstantiationBlock: [ 
			| d |
			d := IdentityDictionary new.
			d at: 'a' put: 'abc'.
			d ]
		literal: '{"class":"IdentityDictionary","instance":{"a":"abc"}}'
		testEq: false "#assertEquivalent: doesn't work for this type of object"
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeIdentityDictionary2Entries [
	"Entries in a dictionary are unordered. So, serialization may result into different valid results."
	| serializationBlock validSerializationStrings jsSerialization pharoSerialization |
	serializationBlock := [ | d |
			d := IdentityDictionary new.
			d at: 'a' put: 'abc'.
			d at: 'b' put: '123'.
			d asPhxJsonString ].
	validSerializationStrings := #(
		'{"class":"IdentityDictionary","instance":{"a":"abc","b":"123"}}'
		'{"class":"IdentityDictionary","instance":{"b":"123","a":"abc"}}').
	jsSerialization := self evalBlock: serializationBlock.
	pharoSerialization := serializationBlock value.
	{jsSerialization. pharoSerialization} do: [ : serialization |
		self assert: (validSerializationStrings includes: serialization)
	]
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeInstRefs [
	"objects should be checked by identity!!!"

	| a |
	a := {}.
	self
		assert: [ {a.
			a} asPhxJsonString ]
		evaluatesTo:
			'{"class":"Array","instance":[{"class":"Array","instance":[]},{"instRef":2}]}'.
	self
		assertEquivalent: [ {a.
			a} asPhxJsonString ]
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeInstRefsAvoidWhenDifferentInstances [
	"objects should be checked by identity!!!"

	self
		assert: [ {{}.
			{}} asPhxJsonString ]
		evaluatesTo:
			'{"class":"Array","instance":[{"class":"Array","instance":[]},{"class":"Array","instance":[]}]}'.
	self
		assertEquivalent: [ {{}.
			{}} asPhxJsonString ]
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeNil [
	self
		assertAllWithInstantiationBlock: [ nil  ]
		literal: 'null'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeNumber [
	self
		assertAllWithInstantiationBlock: [ 123456789  ]
		literal: '123456789'
		testEq: true
		test4Stages: true.
	self
		assertAllWithInstantiationBlock: [ 12345.6789  ]
		literal: '12345.6789'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeOrderedCollection [
	"On js side, OrderedCollection does not exist!!! "
	"Auto transpiled to Array."

	self
		assertAllWithInstantiationBlock: [ OrderedCollection new ]
		literal: '{"class":"Array","instance":[]}'
		testEq: false "don't test because it's an Array client side"
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeSimpleObject [

	self
		assertAllWithInstantiationBlock: [ PhxJsonTestResources testOrg1 ]
		literal: PhxJsonTestResources testOrg1 asPhxJsonString
		testEq: false "#assertEquivalent: doesn't work for this type of object"
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeString [
	self
		assertAllWithInstantiationBlock: [ PhxJsonTestResources challengingStringRequiringUnicodeAndEscapement
				 ]
		literal:
			PhxJsonTestResources challengingStringRequiringUnicodeAndEscapement
				asPhxJsonString
		testEq: true
		test4Stages: true
]

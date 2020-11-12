Class {
	#name : #PhxBridgedJsonSerialisationTests,
	#superclass : #PjBridgeTestCase,
	#category : #PharoJsSerializationTest
}

{ #category : #private }
PhxBridgedJsonSerialisationTests >> assertAllWithInstantiationBlock: aBlock literal: jsonString testEq: testEq test4Stages: test4Stages [
	self assert: aBlock evaluatesTo: jsonString.
	testEq ifTrue: [self assertEquivalent: aBlock].
	self isEqualAfterWriteReadInJs: aBlock.
	test4Stages ifTrue: [self isEqualAfter4StageMarshalingInBothWorlds: aBlock]
]

{ #category : #private }
PhxBridgedJsonSerialisationTests >> isEqualAfter4StageMarshalingInBothWorlds: aBlock [
	| jsonStringOfObject objectProxy serializedInJsWorld materializedObjectSmalltalk serializedInSmalltalkWorld stringifiedAfterMaterializedInJsWorld |
	objectProxy := self evalBlock: aBlock.
	serializedInJsWorld := self
		evalBlock: [ objectProxy asPhxJsonString ].
	materializedObjectSmalltalk := PhxJsonReader
		readFromString: serializedInJsWorld.
	serializedInSmalltalkWorld := materializedObjectSmalltalk
		asPhxJsonString.
	stringifiedAfterMaterializedInJsWorld := self
		evalBlock: [ JSON
				stringify: (PhxJsonReader readFromString: serializedInSmalltalkWorld) ].
	jsonStringOfObject := self evalBlock: [ JSON stringify: objectProxy ].
	self
		assert: stringifiedAfterMaterializedInJsWorld
		equals: jsonStringOfObject
]

{ #category : #private }
PhxBridgedJsonSerialisationTests >> isEqualAfterWriteReadInJs: aBlock [
	| jsonStringAfterWriteRead jsonStringOfObject objectProxy |
	objectProxy := self evalBlock: aBlock.
	jsonStringAfterWriteRead := self
		evalBlock: [ JSON
				stringify: (PhxJsonReader readFromString: objectProxy asPhxJsonString) ].
	jsonStringOfObject := self evalBlock: [ JSON stringify: objectProxy ].
	self assert: jsonStringAfterWriteRead equals: jsonStringOfObject
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeArray [
	self
		assertAllWithInstantiationBlock: [ {} asPhxJsonString ]
		literal: '{"class":"Array","instance":[]}'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeAssociations [
	self
		assertAllWithInstantiationBlock: [{ 'een' -> 1. 'twee' -> 2 }  asPhxJsonString ]
		literal: '{"class":"Array","instance":[{"class":"Association","instance":{"key":"een","value":1}},{"class":"Association","instance":{"key":"twee","value":2}}]}'
		testEq: false
		test4Stages: false
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeBoolean [
	self
		assertAllWithInstantiationBlock: [ true asPhxJsonString ]
		literal: 'true'
		testEq: true
		test4Stages: true.
	self
		assertAllWithInstantiationBlock: [ false asPhxJsonString ]
		literal: 'false'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeChallengingObject [
	self
		assertAllWithInstantiationBlock: [ PhxJsonTestResources challingingObjectAvoidingDateAndTime  asPhxJsonString ]
		literal: PhxJsonTestResources challingingObjectAvoidingDateAndTime asPhxJsonString
		testEq: true
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
			d asPhxJsonString ]
		literal: '{"class":"DateAndTime","instance":"2020-04-11T23:02:03.000Z"}'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeDateAndTime [
	<expectedFailure>
	self
		assertAllWithInstantiationBlock: [ | d |
			d := DateAndTime
				year: 2020
				month: 04
				day: 11
				hour: 23
				minute: 2
				second: 3.
			d asPhxJsonString ]
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
			d asPhxJsonString ]
		literal: '{"class":"Dictionary","instance":{"a":"abc","b":"123"}}'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeEmptyObject [
	self
		assertAllWithInstantiationBlock: [ Object new asPhxJsonString ]
		literal: '{"class":"Object","instance":{}}'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeIdentityDictionary [
	self
		assertAllWithInstantiationBlock: [ | d |
			d := IdentityDictionary new.
			d at: 'a' put: 'abc'.
			d at: 'b' put: '123'.
			d asPhxJsonString ]
		literal: '{"class":"IdentityDictionary","instance":{"a":"abc","b":"123"}}'
		testEq: true
		test4Stages: true
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
		assertAllWithInstantiationBlock: [ nil asPhxJsonString ]
		literal: 'null'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeNumber [
	self
		assertAllWithInstantiationBlock: [ 123456789 asPhxJsonString ]
		literal: '123456789'
		testEq: true
		test4Stages: true.
	self
		assertAllWithInstantiationBlock: [ 12345.6789 asPhxJsonString ]
		literal: '12345.6789'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeOrderedCollection [
	"On js side, OrderedCollection does not exist!!! "

	"Auto transpiled to Array."

	self
		assertAllWithInstantiationBlock: [ OrderedCollection new asPhxJsonString ]
		literal: '{"class":"Array","instance":[]}'
		testEq: false
		test4Stages: false
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeString [
	self
		assertAllWithInstantiationBlock: [ PhxJsonTestResources challengingStringRequiringUnicodeAndEscapement
				asPhxJsonString ]
		literal:
			PhxJsonTestResources challengingStringRequiringUnicodeAndEscapement
				asPhxJsonString
		testEq: true
		test4Stages: true
]

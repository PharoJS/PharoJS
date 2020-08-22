Class {
	#name : #PhxBridgedJsonSerialisationTests,
	#superclass : #PjBridgeTestCase,
	#category : #PharoJsSerializationTest
}

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> _testSerializeDateAndTime [
	self
		testAllWithInstantiationBlock: [ | d |
			Date today.
			d := DateAndTime
				year: 2020
				month: 04
				day: 12
				hour: 1
				minute: 2
				second: 3.
			console log: d.
			d asPhxJsonString ]
		literal: '{"class":"DateAndTime","instance":"2020-04-11T23:02:03.000Z"}'
		testEq: true
		test4Stages: true
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

{ #category : #private }
PhxBridgedJsonSerialisationTests >> testAllWithInstantiationBlock: aBlock literal: jsonString testEq: testEq test4Stages: test4Stages [
	self assert: aBlock evaluatesTo: jsonString.
	testEq ifTrue: [self assertEquivalent: aBlock].
	self isEqualAfterWriteReadInJs: aBlock.
	test4Stages ifTrue: [self isEqualAfter4StageMarshalingInBothWorlds: aBlock]
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testProperInstRefOrderWhenUsingCollections [
	"this problem can be observed without JS side"

	| obj problemObject string |
	obj := Object new.
	problemObject := {obj.
	{obj}}.
	string := problemObject asPhxJsonString.
	self shouldnt: [ PhxJsonReader readFromString: string ] raise: Error
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeArray [
	self
		testAllWithInstantiationBlock: [ {} asPhxJsonString ]
		literal: '{"class":"Array","instance":[]}'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeAssociations [
	self
		testAllWithInstantiationBlock: [{ 'een' -> 1. 'twee' -> 2 }  asPhxJsonString ]
		literal: '{"class":"Array","instance":[{"class":"Association","instance":{"key":"een","value":1}},{"class":"Association","instance":{"key":"twee","value":2}}]}'
		testEq: false
		test4Stages: false
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeBoolean [
	self
		testAllWithInstantiationBlock: [ true asPhxJsonString ]
		literal: 'true'
		testEq: true
		test4Stages: true.
	self
		testAllWithInstantiationBlock: [ false asPhxJsonString ]
		literal: 'false'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeChallengingObject [
	self
		testAllWithInstantiationBlock: [ PhxJsonTestResources challingingObjectAvoidingDateAndTime  asPhxJsonString ]
		literal: PhxJsonTestResources challingingObjectAvoidingDateAndTime asPhxJsonString
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeDictionary [
	self
		testAllWithInstantiationBlock: [ | d |
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
		testAllWithInstantiationBlock: [ Object new asPhxJsonString ]
		literal: '{"class":"Object","instance":{}}'
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
		testAllWithInstantiationBlock: [ nil asPhxJsonString ]
		literal: 'null'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeNumber [
	self
		testAllWithInstantiationBlock: [ 123456789 asPhxJsonString ]
		literal: '123456789'
		testEq: true
		test4Stages: true.
	self
		testAllWithInstantiationBlock: [ 12345.6789 asPhxJsonString ]
		literal: '12345.6789'
		testEq: true
		test4Stages: true
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeOrderedCollection [
	"On js side, OrderedCollection does not exist!!! "

	"Auto transpiled to Array."

	self
		testAllWithInstantiationBlock: [ OrderedCollection new asPhxJsonString ]
		literal: '{"class":"Array","instance":[]}'
		testEq: false
		test4Stages: false
]

{ #category : #tests }
PhxBridgedJsonSerialisationTests >> testSerializeString [
	self
		testAllWithInstantiationBlock: [ PhxJsonTestResources challengingStringRequiringUnicodeAndEscapement
				asPhxJsonString ]
		literal:
			PhxJsonTestResources challengingStringRequiringUnicodeAndEscapement
				asPhxJsonString
		testEq: true
		test4Stages: true
]

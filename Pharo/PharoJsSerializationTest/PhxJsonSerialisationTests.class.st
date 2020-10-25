Class {
	#name : #PhxJsonSerialisationTests,
	#superclass : #TestCase,
	#category : #PharoJsSerializationTest
}

{ #category : #tests }
PhxJsonSerialisationTests >> testProperInstRefOrderWhenUsingCollections [
	| obj problemObject string |
	obj := Object new.
	problemObject := {obj.
	{obj}}.
	string := problemObject asPhxJsonString.
	self shouldnt: [ PhxJsonReader readFromString: string ] raise: Error
]

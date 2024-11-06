"
A JSON Reader - to read an object from JSON format
"
Class {
	#name : 'PhxJsonReader',
	#superclass : 'PjDomController',
	#instVars : [
		'knownObjects'
	],
	#category : 'PharoJs-Base-Serialization-Core',
	#package : 'PharoJs-Base-Serialization',
	#tag : 'Core'
}

{ #category : 'instance creation' }
PhxJsonReader class >> materializeJsonString: aString [
	<javascript: 'return JSON.parse(aString)'>
	"returns a javascript object in js world"
	"returns a dictionary in st world"
	
	^ STONJSON fromString: aString readStream
]

{ #category : 'instance creation' }
PhxJsonReader class >> readFromJsObjectOrDictionary: jsObjectOrDictionary [

	^ self new readFromJsObjectOrDictionary: jsObjectOrDictionary
]

{ #category : 'instance creation' }
PhxJsonReader class >> readFromString: aString [

	^ self readFromJsObjectOrDictionary: (self materializeJsonString: aString)
]

{ #category : 'instance creation' }
PhxJsonReader >> addKnownObject: anObject [
	^knownObjects add: anObject
]

{ #category : 'instance creation' }
PhxJsonReader >> classNameForJsonClassName: jsonClassName [
	<javascript:
		'if(jsonClassName == "DateAndTime") { return "Date"}
if(jsonClassName == "Dictionary") { return "PjDictionary"}
if(jsonClassName == "Association") { return "PjAssociation"}
if(jsonClassName == "IdentityDictionary") { return "PjIdentityDictionary"}
if(jsonClassName == "Set") { return "PjSet"}
if(jsonClassName == "Announcer") { return "PjAnnouncer"}
if(jsonClassName == "AnnouncementSubscription") { return "PjAnnouncementSubscription"}
if(jsonClassName == "SubscriptionRegistry") { return "PjSubscriptionRegistry"}
if(jsonClassName == "OrderedCollection") { return "PjOrderedCollection" }
return jsonClassName;'>
	^ jsonClassName
]

{ #category : 'initialize-release' }
PhxJsonReader >> initialize [
	knownObjects := OrderedCollection new
]

{ #category : 'instance creation' }
PhxJsonReader >> readFromJsObjectOrDictionary: jsonObject [
	| jsonClassName |
	jsonObject ifNil: [ ^ nil ].
	jsonObject isString
		ifTrue: [ ^ jsonObject ].
	jsonObject isNumber
		ifTrue: [ ^ jsonObject ].
	jsonObject == true
		ifTrue: [ ^ true ].
	jsonObject == false
		ifTrue: [ ^ false ].
	(jsonObject at: 'instRef' ifAbsent: [ nil ])
		ifNotNil: [ :idx | ^ knownObjects at: idx ].
	jsonClassName := jsonObject at: 'class' ifAbsent: [ nil ].
	(self classNameForJsonClassName: jsonClassName)
		ifNotNil: [ :className | 
			| class instJsonObject |
			class := Smalltalk at: className asSymbol ifAbsent: [ nil ].
			class ifNil: [ self error: 'Class not found: ' , className ].
			instJsonObject := jsonObject at: 'instance'.
			^ (class
						instantiateWithPhxJsonReader: self
						instanceJsonObject: instJsonObject) ].
	^ self error
]

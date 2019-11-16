Class {
	#name : #PjDummyTestObject,
	#superclass : #Object,
	#classInstVars : [
		'string'
	],
	#category : #'PharoJsCoreLibrariesTest-Collections'
}

{ #category : #accessing }
PjDummyTestObject class >> string [
	^string
]

{ #category : #accessing }
PjDummyTestObject class >> string: aString [
	string := aString
]

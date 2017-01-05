Class {
	#name : #PjUser,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'PharoJsExamples-HelloWorld'
}

{ #category : #accessing }
PjUser >> name [
	^name
]

{ #category : #accessing }
PjUser >> name: anObject [
	name := anObject
]

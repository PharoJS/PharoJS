Class {
	#name : #PjMessage,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #'instance creation' }
PjMessage class >> newWithContents: contents [
	^ self new
		contents: contents;
		yourself
]

{ #category : #accessing }
PjMessage >> contents [
	^ contents
]

{ #category : #accessing }
PjMessage >> contents: anObject [
	contents := anObject
]

{ #category : #printing }
PjMessage >> logDescription [
	^ self contents
]

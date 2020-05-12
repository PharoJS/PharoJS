Class {
	#name : #PjMessage,
	#superclass : #PjDomController,
	#instVars : [
		'contents',
		'id'
	],
	#classVars : [
		'currentId'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #'instance creation' }
PjMessage class >> newWithContents: contents [
	^ self new
		contents: contents;
		id: self nextMessageId;
		yourself
]

{ #category : #'instance creation' }
PjMessage class >> nextMessageId [
	currentId := currentId ifNil: [ 1 ] ifNotNil: [ :id | id + 1 ].
	^ currentId
]

{ #category : #accessing }
PjMessage >> contents [
	^ contents
]

{ #category : #accessing }
PjMessage >> contents: anObject [
	contents := anObject
]

{ #category : #public }
PjMessage >> evaluateInContext: aMessageContext [
	self subclassResponsibility 
]

{ #category : #accessing }
PjMessage >> id [
	^ id
]

{ #category : #accessing }
PjMessage >> id: anObject [
	id := anObject
]

{ #category : #printing }
PjMessage >> logDescription [
	^ String
		streamContents: [ :ws | 
			ws nextPutAll: self class name.
			ws nextPutAll: ' id: '.
			ws nextPutAll: self id printString.
			self contents
				ifNotNil: [ :c | 
					ws nextPutAll: ' contents: '.
					ws nextPutAll: c ] ]
]

{ #category : #'socket behavior' }
PjMessage >> timeout: aBlock for: milliseconds [
	<javascript: 'setTimeout(aBlock,milliseconds)'>
]

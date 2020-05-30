Class {
	#name : #PjMessage,
	#superclass : #PjDomController,
	#instVars : [
		'contents',
		'id',
		'addresseeId'
	],
	#classVars : [
		'currentId'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #'instance creation' }
PjMessage class >> newWithContents: contents [
	^ self newWithId
		contents: contents;
		yourself
]

{ #category : #'instance creation' }
PjMessage class >> newWithId [
	^ self new
		id: self nextMessageId;
		yourself
]

{ #category : #'instance creation' }
PjMessage class >> nextMessageId [
	currentId := currentId ifNil: [ 1 ] ifNotNil: [ :id | id + 1 ].
	^ currentId
]

{ #category : #accessing }
PjMessage >> addresseeId [
	^ addresseeId
]

{ #category : #accessing }
PjMessage >> addresseeId: anObject [
	addresseeId := anObject
]

{ #category : #accessing }
PjMessage >> contents [
	^ contents
]

{ #category : #accessing }
PjMessage >> contents: anObject [
	contents := anObject
]

{ #category : #accessing }
PjMessage >> id [
	^ id
]

{ #category : #accessing }
PjMessage >> id: anObject [
	id := anObject
]

{ #category : #'initialize-release' }
PjMessage >> initialize [
	super initialize.

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

{ #category : #testing }
PjMessage >> needsToBeQueued [
	^true
]

{ #category : #printing }
PjMessage >> printOn: ws [
	<pharoJsSkip>
	super printOn: ws.
	ws space.
	ws << 'id:'.
	ws << self id.

]

{ #category : #'socket behavior' }
PjMessage >> timeout: aBlock for: milliseconds [
	<javascript: 'setTimeout(aBlock,milliseconds)'>
]

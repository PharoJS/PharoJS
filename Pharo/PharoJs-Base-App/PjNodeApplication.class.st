"
I am the abstract superclass that all server-side PharoJS applications should extend (directly or indirectly)

"
Class {
	#name : #PjNodeApplication,
	#superclass : #PjApplication,
	#pools : [
		'PjNodeGlobals'
	],
	#category : #'PharoJs-Base-App'
}

{ #category : #accessing }
PjNodeApplication class >> headerLine [
	<pharoJsSkip>
	
	^ '#! /usr/bin/env node'
]

{ #category : #testing }
PjNodeApplication class >> isAbstract [

	^ self = PjNodeApplication 
					ifTrue: [ ^ true ]
		 		   ifFalse: [ super isAbstract ]
]

{ #category : #pj }
PjNodeApplication class >> playgroundInitialContent [
	<pharoJsSkip>
	^	super playgroundInitialContent
		,'console log: ''hello''.', String cr
		,'global. " inspect this "', String cr
]

{ #category : #private }
PjNodeApplication class >> whenJsReady: aBlock [
	aBlock value
]

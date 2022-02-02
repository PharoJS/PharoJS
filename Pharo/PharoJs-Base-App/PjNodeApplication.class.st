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
]

{ #category : #private }
PjNodeApplication class >> whenJsReady: aBlock [
	aBlock value
]

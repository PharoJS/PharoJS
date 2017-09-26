"
I am the class that all server-side PharoJS applications should extend.

"
Class {
	#name : #PjNodeApplication,
	#superclass : #PjApplication,
	#pools : [
		'PjNodeGlobals'
	],
	#category : #PharoJsApp
}

{ #category : #accessing }
PjNodeApplication class >> headerLine [
	<pharoJsSkip>
	^ '#! /usr/bin/env node'
]

{ #category : #'start-stop application' }
PjNodeApplication class >> whenJsReady: aBlock [
	aBlock value
]

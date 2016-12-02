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

{ #category : #accessing }
PjNodeApplication >> start [
]

{ #category : #accessing }
PjNodeApplication >> stop [
]

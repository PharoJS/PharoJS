"
I am the abstract superclass that all server-side PharoJS applications should extend (directly or indirectly)

To open playground for concrete subclasses or run tests via PharoJS test framework, please ensure node package ws (https://www.npmjs.com/package/ws) is installed in your system.

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

{ #category : #private }
PjNodeApplication class >> whenJsReady: aBlock [
	aBlock value
]

{ #category : #accessing }
PjNodeApplication >> moduleNamed: aString [
	^self modulesManager moduleNamed: aString
]

{ #category : #accessing }
PjNodeApplication >> modulesManager [
	^PjNodeModulesManager default
]

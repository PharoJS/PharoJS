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

{ #category : #accessing }
PjNodeApplication class >> modulesFolder [

	<pharoJsSkip>
	^ (self appFolder / self modulesFolderName) 
]

{ #category : #accessing }
PjNodeApplication class >> modulesFolderName [
	^'node_modules'
]

{ #category : #private }
PjNodeApplication class >> whenJsReady: aBlock [
	aBlock value
]

{ #category : #accessing }
PjNodeApplication >> dirName [

"__dirname is an environment variable that tells you the absolute path of the directory containing the currently executing file."
	<javascript: 'return __dirname'>
	
]

{ #category : #accessing }
PjNodeApplication >> fullPathFor: relativePathName [
	^self pathFactory
		        join: self dirName
		        with: relativePathName
]

{ #category : #accessing }
PjNodeApplication >> moduleNamed: aString [
	^self modulesManager moduleNamed: aString
]

{ #category : #accessing }
PjNodeApplication >> modulesManager [
	^PjNodeModulesManager default
]

{ #category : #accessing }
PjNodeApplication >> pathFactory [

	^ self moduleNamed: 'path'
]

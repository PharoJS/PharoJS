Class {
	#name : #PjProxyForGlobalsTest,
	#superclass : #TestCase,
	#instVars : [
		'classFactory',
		'authorInitialName'
	],
	#category : #'PharoJsBridgeTest-Tests'
}

{ #category : #running }
PjProxyForGlobalsTest >> setUp [
	super setUp.
	authorInitialName := Author uniqueInstance fullNamePerSe.
	Author uniqueInstance fullName: 'PharoJS'.
	classFactory := ClassFactoryForTestCase new
]

{ #category : #running }
PjProxyForGlobalsTest >> tearDown [
	super tearDown.
	classFactory ifNotNil: [ classFactory cleanUp ].
	Author uniqueInstance fullName: authorInitialName.

]

{ #category : #running }
PjProxyForGlobalsTest >> testProxyForNewGlobalsCreated [
	| globalsPool |
	globalsPool := classFactory silentlyNewSubclassOf: PjJavascriptGlobals instanceVariableNames: '' classVariableNames: 'A B'.
	globalsPool class 
		compile: 'globals
		^{A. B}'.
	globalsPool globals do: [ : each |
		self assert: (each isKindOf: PjProxy) ]
]

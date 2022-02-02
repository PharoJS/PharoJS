Class {
	#name : #PjProxyForGlobalsTest,
	#superclass : #TestCase,
	#instVars : [
		'classFactory',
		'authorInitialName'
	],
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
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

{ #category : #tests }
PjProxyForGlobalsTest >> testProxyForNewGlobalsCreated [

	| globalsPool userClass |
	globalsPool := classFactory silentlyNewSubclassOf: PjJavascriptGlobals instanceVariableNames: '' classVariableNames: 'A B'.
	userClass := classFactory newSubclassOf: Object uses: #() instanceVariableNames: '' classVariableNames: '' poolDictionaries: globalsPool name category: classFactory defaultCategory.
	userClass class 
		compile: 'globals
		^{A. B}'.
	userClass globals do: [ : each |
		self assert: (each isKindOf: PjProxy) ]
]

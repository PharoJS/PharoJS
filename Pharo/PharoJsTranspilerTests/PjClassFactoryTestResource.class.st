Class {
	#name : #PjClassFactoryTestResource,
	#superclass : #TestResource,
	#instVars : [
		'classFactory',
		'defaultClass',
		'authorInitialName'
	],
	#category : #'PharoJsTranspilerTests-Support'
}

{ #category : #running }
PjClassFactoryTestResource >> classFactory [
	^classFactory
]

{ #category : #running }
PjClassFactoryTestResource >> defaultClass [
	^defaultClass
]

{ #category : #running }
PjClassFactoryTestResource >> setUp [
	super setUp.
	authorInitialName := Author uniqueInstance fullNamePerSe.
	Author uniqueInstance fullName: 'PharoJS'.
	classFactory := ClassFactoryForTestCase new.
	defaultClass := classFactory silentlyNewClassInCategory: classFactory packageName.
]

{ #category : #running }
PjClassFactoryTestResource >> tearDown [
	super tearDown.
	classFactory cleanUp.
	Author uniqueInstance fullName: authorInitialName.
]

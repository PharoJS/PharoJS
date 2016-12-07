Class {
	#name : #PjClassFactoryTestResource,
	#superclass : #TestResource,
	#instVars : [
		'classFactory',
		'defaultClass'
	],
	#category : #'PharoJsTranspiler-Tests-Support'
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
	classFactory := ClassFactoryForTestCase new.
	defaultClass := classFactory silentlyNewClassInCategory: classFactory packageName.
]

{ #category : #running }
PjClassFactoryTestResource >> tearDown [
	super tearDown.
	classFactory cleanUp.

]

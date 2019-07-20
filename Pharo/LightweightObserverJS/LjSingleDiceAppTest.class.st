Class {
	#name : #LjSingleDiceAppTest,
	#superclass : #PjWebAppTestCase,
	#instVars : [
		'faceUpDisplay'
	],
	#category : #'LightweightObserverJS-Example'
}

{ #category : #'suite parameters' }
LjSingleDiceAppTest class >> appClass [
	^LjSingleDiceApp
]

{ #category : #testing }
LjSingleDiceAppTest >> setUp [
	super setUp.
	faceUpDisplay := app view
]

{ #category : #testing }
LjSingleDiceAppTest >> testClickingOnDisplayMakesDiceRoll [
	| faceUpDisplayString |
	100 timesRepeat: [
		faceUpDisplayString := faceUpDisplay textContent. 
		faceUpDisplay click.
		faceUpDisplayString = faceUpDisplay textContent ifFalse: [ ^self ].
		].
	self fail
]

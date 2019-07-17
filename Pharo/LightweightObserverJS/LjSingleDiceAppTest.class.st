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
	| isFaceUpChanged faceUpDisplayHtml |
	isFaceUpChanged := false.
	faceUpDisplayHtml := faceUpDisplay innerHTML. 
	100 timesRepeat: [
		faceUpDisplay click.
		faceUpDisplayHtml = faceUpDisplay innerHTML ifFalse: [ ^self ].
		].
	self fail
]

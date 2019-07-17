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
	| faceUpDisplayHtml |
	100 timesRepeat: [
		faceUpDisplayHtml := faceUpDisplay innerHTML. 
		faceUpDisplay click.
		faceUpDisplayHtml = faceUpDisplay innerHTML ifFalse: [ ^self ].
		].
	self fail
]

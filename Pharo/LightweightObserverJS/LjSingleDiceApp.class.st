Class {
	#name : #LjSingleDiceApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'model',
		'view',
		'controller'
	],
	#category : #'LightweightObserverJS-Example'
}

{ #category : #description }
LjSingleDiceApp class >> appJsSubFolder [
	^'js'
]

{ #category : #initialization }
LjSingleDiceApp >> initialize [
	super initialize.
	model := LoDice new. 
	view := self elementAt: #diceView.
	controller := LjDiceController new.
	controller dice: model faceUpDisplay: view.
]

{ #category : #initialization }
LjSingleDiceApp >> view [	
	^view
]

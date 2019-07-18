Class {
	#name : #LjDiceListApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'model',
		'view',
		'controller'
	],
	#category : #'LightweightObserverJS-Example'
}

{ #category : #description }
LjDiceListApp class >> appJsSubFolder [
	^'js'
]

{ #category : #initialization }
LjDiceListApp >> initialize [
	super initialize.
	model := LoDiceList withDiceCount: 3. 
	view := self elementAt: #diceListView.
	controller := LjDiceListController new.
	controller diceList: model diceListDisplay: view.
	(self elementAt: #addDiceButton) addEventListener: #click block: [ model addDice ].
	(self elementAt: #removeDiceButton) addEventListener: #click block: [ model removeDice ].
	
]

{ #category : #initialization }
LjDiceListApp >> model [	
	^model
]

{ #category : #initialization }
LjDiceListApp >> view [	
	^view
]

Class {
	#name : #LjDiceListApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'diceList',
		'diceListDisplay',
		'diceListController'
	],
	#category : #'LightweightObserverJS-Example'
}

{ #category : #description }
LjDiceListApp class >> appJsSubFolder [
	^'js'
]

{ #category : #initialization }
LjDiceListApp >> diceList [	
	^diceList
]

{ #category : #initialization }
LjDiceListApp >> diceListClass [
	^ LoDiceList
]

{ #category : #initialization }
LjDiceListApp >> initialize [
	super initialize.
	diceList := self diceListClass withDiceCount: 3.
	diceListDisplay := self elementAt: #diceListView.
	diceListController := LjDiceListController new.
	diceListController diceList: diceList diceListDisplay: diceListDisplay.
	(self elementAt: #addDiceButton)
		addEventListener: #click
		block: [ diceList addDice ].
	(self elementAt: #removeDiceButton)
		addEventListener: #click
		block: [ self removeDice ].
	(self elementAt: #rollDiceButton)
		addEventListener: #click
		block: [ diceList roll ]
]

{ #category : #initialization }
LjDiceListApp >> removeDice [
	diceList dice size > 2 ifFalse: [ ^self ].
	diceList removeDice
]

{ #category : #initialization }
LjDiceListApp >> view [	
	^diceListDisplay
]

Class {
	#name : #LjDiceListAppTest,
	#superclass : #PjWebAppTestCase,
	#instVars : [
		'diceListView',
		'diceList'
	],
	#category : #'LightweightObserverJS-Example'
}

{ #category : #'suite parameters' }
LjDiceListAppTest class >> appClass [
	^LjDiceListApp
]

{ #category : #testing }
LjDiceListAppTest >> denyCollection: someCollection hasSameElements: otherCollection [
	self deny: (someCollection includesAll: otherCollection)
]

{ #category : #testing }
LjDiceListAppTest >> diceDisplayStrings [
	^diceListView children collect: [ : singDiceView |
		singDiceView textContent
	].
	

]

{ #category : #testing }
LjDiceListAppTest >> setUp [
	super setUp.
	diceListView := app view.
	diceList := app model.
]

{ #category : #testing }
LjDiceListAppTest >> testClickOnAddRemoveDiceButtons [
	| addButton removeButton previousSize currentSize |
	addButton := document getElementById: #addDiceButton.
	previousSize := diceListView children size.
	5 timesRepeat: [ 
		addButton click. 
		currentSize := diceListView children size.
		self assert: currentSize equals: previousSize + 1.
		previousSize := currentSize
	].
	removeButton := document getElementById: #removeDiceButton.
	5 timesRepeat: [ 
		removeButton click. 
		currentSize := diceListView children size.
		self assert: currentSize equals: previousSize - 1.
		previousSize := currentSize
	]

	
]

{ #category : #testing }
LjDiceListAppTest >> testClickOnRollButtonMakesDiceRoll [
	| initialDiceStrings rollButton |
	self deny: diceListView children isEmpty.
	initialDiceStrings := self diceDisplayStrings.
	rollButton := document getElementById: #rollDiceButton.
	10 timesRepeat: [ 
		rollButton click. 
		(self diceDisplayStrings includesAll: initialDiceStrings) ifFalse: [^self]].
	self fail
]

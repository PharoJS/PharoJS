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
LjDiceListAppTest >> assertDiceRollsAfterClickOn: singDiceView [
	| faceUpDisplayHtml |
	100 timesRepeat: [
		faceUpDisplayHtml := singDiceView innerHTML. 
		diceListView click.
		faceUpDisplayHtml = singDiceView innerHTML ifFalse: [ ^self ].
	].
	self fail
]

{ #category : #testing }
LjDiceListAppTest >> orderedCollectionFrom: jsCollection [
	| elementsCount localCollection |
	elementsCount := jsCollection size.
	localCollection := OrderedCollection new: elementsCount.
	0 to: elementsCount - 1 do: [ : index |
		localCollection add: (jsCollection at: index) ].
	^localCollection
]

{ #category : #testing }
LjDiceListAppTest >> setUp [
	super setUp.
	diceListView := app view.
	diceList := app model.
]

{ #category : #testing }
LjDiceListAppTest >> testClickingOnDiceDisplayMakesDiceRoll [
	diceListView children do: [ : singDiceView |
		self assertDiceRollsAfterClickOn: singDiceView
	]

]

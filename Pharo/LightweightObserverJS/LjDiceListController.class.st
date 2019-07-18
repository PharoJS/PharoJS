Class {
	#name : #LjDiceListController,
	#superclass : #PjDomController,
	#instVars : [
		'diceList',
		'diceControllers',
		'diceListDisplay'
	],
	#category : #'LightweightObserverJS-Example'
}

{ #category : #observing }
LjDiceListController >> addControllerForDice: aDice [
	| diceView controller |
	diceView := self createElement: 'span'.
	diceView classList add: 'diceFace'. 
	controller := LjDiceController new.
	controller dice: aDice faceUpDisplay: diceView.
	diceControllers addLast: controller.
	diceListDisplay appendChild: diceView.
]

{ #category : #'initialize-release' }
LjDiceListController >> diceList: aDiceList diceListDisplay: htmlElement [
	diceControllers := OrderedCollection new.
	diceList := aDiceList.
	diceListDisplay := htmlElement.
	aDiceList dice do: [ : aDice | self addControllerForDice: aDice].
	aDiceList 
		afterAddToCollection: #dice 
		do: [ : newDice | self addControllerForDice: newDice ].
	aDiceList 
		afterRemoveFromCollection: #dice 
		do: [ : oldDice : oldDiceIndex | self removeDiceControllerAt: oldDiceIndex ].
	
]

{ #category : #observing }
LjDiceListController >> removeDiceControllerAt: index [
	| diceView controller |
	controller := diceControllers at: index.
	diceView := controller view.
	diceListDisplay removeChild: diceView.
	diceControllers remove: controller.

]

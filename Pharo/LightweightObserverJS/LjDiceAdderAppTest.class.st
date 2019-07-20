Class {
	#name : #LjDiceAdderAppTest,
	#superclass : #LjDiceListAppTest,
	#category : #'LightweightObserverJS-Example'
}

{ #category : #'suite parameters' }
LjDiceAdderAppTest class >> appClass [
	^LjDiceAdderApp
]

{ #category : #tests }
LjDiceAdderAppTest >> testTotalUpdatedUponAddingDice [
	| totalView initialTotal addButton |
	totalView := document getElementById: #diceTotalView.
	initialTotal := totalView textContent.
	addButton := document getElementById: #addDiceButton.
	addButton click.
	self deny: totalView textContent = initialTotal

]

{ #category : #tests }
LjDiceAdderAppTest >> testTotalUpdatedUponRemovingDice [
	| totalView initialTotal removeButton |
	totalView := document getElementById: #diceTotalView.
	initialTotal := totalView textContent.
	removeButton := document getElementById: #removeDiceButton.
	removeButton click.
	self deny: totalView textContent = initialTotal

]

{ #category : #tests }
LjDiceAdderAppTest >> testTotalUpdatedUponRollingDice [
	| totalView initialTotal rollButton |
	totalView := document getElementById: #diceTotalView.
	initialTotal := totalView textContent.
	rollButton := document getElementById: #rollDiceButton.
	10 timesRepeat: [ 
		rollButton click. 
		totalView textContent = initialTotal ifFalse: [^self]].
	self fail
]

Class {
	#name : #LjDiceAdderApp,
	#superclass : #LjDiceListApp,
	#category : #'LightweightObserverJS-Example'
}

{ #category : #initialization }
LjDiceAdderApp >> diceListClass [
	^LoDiceAdder
]

{ #category : #initialization }
LjDiceAdderApp >> initialize [
	| totalView |
	super initialize.
	totalView := self elementAt: #diceTotalView.
	diceList afterChangeOf: #total do: [: newTotal | totalView textContent: newTotal ].
	totalView textContent: diceList total.
]

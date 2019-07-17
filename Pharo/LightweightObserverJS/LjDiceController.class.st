Class {
	#name : #LjDiceController,
	#superclass : #Object,
	#instVars : [
		'dice',
		'faceUpDisplay'
	],
	#category : #'LightweightObserverJS-Example'
}

{ #category : #accessing }
LjDiceController >> dice [
	^ dice
]

{ #category : #'initialize-release' }
LjDiceController >> dice: aDice faceUpDisplay: htmlElement [
	dice := aDice.
	faceUpDisplay := htmlElement.
	faceUpDisplay addEventListener: #click block: [ dice roll ].
	dice afterChangeOf: #faceUp do: [ : newFaceUp |  self diceFaceUp: newFaceUp].
	self diceFaceUp: dice faceUp
]

{ #category : #accessing }
LjDiceController >> diceFaceUp: newFaceUp [
	faceUpDisplay innerHTML: newFaceUp
]

{ #category : #accessing }
LjDiceController >> faceUpDisplay [
	^ faceUpDisplay
]

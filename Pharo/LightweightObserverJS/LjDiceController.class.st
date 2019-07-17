Class {
	#name : #LjDiceController,
	#superclass : #PjDomController,
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
LjDiceController >> diceFaceChangedCssClass [
	^'diceFaceChanged'
]

{ #category : #accessing }
LjDiceController >> diceFaceUp: newFaceUp [
	"Change CSS style for about 100 milliseconds to give a visual cue of that the dice changed.
	This is usefull if the values are the same"
	faceUpDisplay classList add: self diceFaceChangedCssClass.
	faceUpDisplay innerHTML: newFaceUp.
	self 
		setTimeout: [
			faceUpDisplay classList remove: self diceFaceChangedCssClass] 
		afterMilliseconds: 100

]

{ #category : #accessing }
LjDiceController >> faceUpDisplay [
	^ faceUpDisplay
]

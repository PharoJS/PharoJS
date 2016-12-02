Class {
	#name : #PjCounterController,
	#superclass : #Object,
	#instVars : [
		'counter',
		'updateDisplayBlock'
	],
	#category : #'PharoJsExamples-Counter'
}

{ #category : #accessing }
PjCounterController >> counter [
	^ counter
]

{ #category : #accessing }
PjCounterController >> counter: anObject [
	counter := anObject
]

{ #category : #actions }
PjCounterController >> increment [
	self counter increment.
	self updateDisplay
]

{ #category : #actions }
PjCounterController >> reset [
	self counter reset.
	self updateDisplay
]

{ #category : #displaying }
PjCounterController >> updateDisplay [
	self updateDisplayBlock value: self counter count
]

{ #category : #accessing }
PjCounterController >> updateDisplayBlock [
	^ updateDisplayBlock
]

{ #category : #accessing }
PjCounterController >> updateDisplayBlock: anObject [
	updateDisplayBlock := anObject
]

Class {
	#name : #PjCounterController,
	#superclass : #Object,
	#instVars : [
		'counter',
		'countDisplay'
	],
	#category : #'PharoJsExamples-Counter'
}

{ #category : #accessing }
PjCounterController >> countDisplay [
	^ countDisplay
]

{ #category : #accessing }
PjCounterController >> countDisplay: anObject [
	countDisplay := anObject
]

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
	self countDisplay innerHTML: self counter count
]

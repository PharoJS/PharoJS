Class {
	#name : #PjClassForInitTest,
	#superclass : #Object,
	#instVars : [
		'x'
	],
	#category : #'PharoJs-Base-Bridge-Tests-Initialization'
}

{ #category : #initialization }
PjClassForInitTest >> initialize [ 
		super initialize.
		x := 42
]

{ #category : #accessing }
PjClassForInitTest >> x [

	^ x
]

{ #category : #accessing }
PjClassForInitTest >> x: anObject [

	x := anObject
]

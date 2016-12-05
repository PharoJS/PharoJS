Class {
	#name : #PjDoOptimization,
	#superclass : #PjOptionalMessageConversion,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjDoOptimization >> convertReceiver: aRBMessageNode args: aCollection [
	self flag: #todo.
	^ nil
]

{ #category : #optimizing }
PjDoOptimization >> selector [
	^ #do:
]

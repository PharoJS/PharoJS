Class {
	#name : #PjDoOptimization,
	#superclass : #PjOptionalMessageConversion,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
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

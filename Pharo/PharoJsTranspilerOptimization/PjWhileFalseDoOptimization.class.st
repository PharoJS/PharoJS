Class {
	#name : #PjWhileFalseDoOptimization,
	#superclass : #PjWhileOptimization,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjWhileFalseDoOptimization >> continueValue [
	^ false
]

{ #category : #converting }
PjWhileFalseDoOptimization >> selector [
	^ #whileFalse:
]

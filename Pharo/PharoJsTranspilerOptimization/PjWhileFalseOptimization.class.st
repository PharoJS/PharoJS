Class {
	#name : #PjWhileFalseOptimization,
	#superclass : #PjWhileOptimization,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjWhileFalseOptimization >> continueValue [
	^ false
]

{ #category : #converting }
PjWhileFalseOptimization >> selector [
	^ #whileFalse
]

Class {
	#name : #PjWhileTrueDoOptimization,
	#superclass : #PjWhileOptimization,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjWhileTrueDoOptimization >> continueValue [
	^ true
]

{ #category : #converting }
PjWhileTrueDoOptimization >> selector [
	^ #whileTrue:
]

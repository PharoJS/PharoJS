Class {
	#name : #PjWhileTrueOptimization,
	#superclass : #PjWhileOptimization,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjWhileTrueOptimization >> continueValue [
	^ true
]

{ #category : #converting }
PjWhileTrueOptimization >> selector [
	^ #whileTrue
]

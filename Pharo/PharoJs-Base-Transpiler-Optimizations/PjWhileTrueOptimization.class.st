Class {
	#name : #PjWhileTrueOptimization,
	#superclass : #PjWhileOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjWhileTrueOptimization >> continueValue [
	^ true
]

{ #category : #converting }
PjWhileTrueOptimization >> selector [
	^ #whileTrue
]

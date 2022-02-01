Class {
	#name : #PjWhileTrueDoOptimization,
	#superclass : #PjWhileOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjWhileTrueDoOptimization >> continueValue [
	^ true
]

{ #category : #converting }
PjWhileTrueDoOptimization >> selector [
	^ #whileTrue:
]

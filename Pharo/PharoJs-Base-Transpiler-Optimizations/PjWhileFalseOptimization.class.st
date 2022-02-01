Class {
	#name : #PjWhileFalseOptimization,
	#superclass : #PjWhileOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjWhileFalseOptimization >> continueValue [
	^ false
]

{ #category : #converting }
PjWhileFalseOptimization >> selector [
	^ #whileFalse
]

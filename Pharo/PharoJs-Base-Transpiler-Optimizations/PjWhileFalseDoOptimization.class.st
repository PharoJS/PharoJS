Class {
	#name : #PjWhileFalseDoOptimization,
	#superclass : #PjWhileOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjWhileFalseDoOptimization >> continueValue [
	^ false
]

{ #category : #converting }
PjWhileFalseDoOptimization >> selector [
	^ #whileFalse:
]

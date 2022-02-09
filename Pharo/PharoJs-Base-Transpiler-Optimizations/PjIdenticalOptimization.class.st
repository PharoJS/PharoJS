Class {
	#name : #PjIdenticalOptimization,
	#superclass : #PjComparisonOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjIdenticalOptimization >> operator [
	^ #===
]

{ #category : #accessing }
PjIdenticalOptimization >> selector [
	^#==
]

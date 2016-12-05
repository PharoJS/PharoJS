Class {
	#name : #PjIdenticalOptimization,
	#superclass : #PjComparisonOptimization,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjIdenticalOptimization >> operator [
	^ #===
]

{ #category : #accessing }
PjIdenticalOptimization >> selector [
	^#==
]

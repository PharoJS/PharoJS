Class {
	#name : #PjIdenticalOptimization,
	#superclass : #PjComparisonOptimization,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #accessing }
PjIdenticalOptimization >> isOkWith: receiver and: arg [
	^ true
]

{ #category : #converting }
PjIdenticalOptimization >> operator [
	^ #===
]

{ #category : #accessing }
PjIdenticalOptimization >> selector [
	^#==
]

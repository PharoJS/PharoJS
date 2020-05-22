Class {
	#name : #PjNotIdenticalOptimization,
	#superclass : #PjComparisonOptimization,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjNotIdenticalOptimization >> operator [
	^ #!==
]

{ #category : #accessing }
PjNotIdenticalOptimization >> selector [
	^#~~
]

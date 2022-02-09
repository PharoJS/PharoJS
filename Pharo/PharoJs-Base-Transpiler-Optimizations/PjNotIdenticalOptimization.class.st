Class {
	#name : #PjNotIdenticalOptimization,
	#superclass : #PjComparisonOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjNotIdenticalOptimization >> operator [
	^ #!==
]

{ #category : #accessing }
PjNotIdenticalOptimization >> selector [
	^#~~
]

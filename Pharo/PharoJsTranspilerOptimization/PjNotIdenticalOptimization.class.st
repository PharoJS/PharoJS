Class {
	#name : #PjNotIdenticalOptimization,
	#superclass : #PjIdenticalOptimization,
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

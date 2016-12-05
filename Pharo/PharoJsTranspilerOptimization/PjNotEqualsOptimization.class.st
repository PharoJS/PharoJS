Class {
	#name : #PjNotEqualsOptimization,
	#superclass : #PjEqualsOptimization,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjNotEqualsOptimization >> operator [
	^ #!=
]

{ #category : #accessing }
PjNotEqualsOptimization >> selector [
	^#~=
]

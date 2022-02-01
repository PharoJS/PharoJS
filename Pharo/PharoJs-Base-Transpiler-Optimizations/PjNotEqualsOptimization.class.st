Class {
	#name : #PjNotEqualsOptimization,
	#superclass : #PjEqualsOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjNotEqualsOptimization >> operator [
	^ #!=
]

{ #category : #accessing }
PjNotEqualsOptimization >> selector [
	^#~=
]

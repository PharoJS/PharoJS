Class {
	#name : 'PjNotEqualsOptimization',
	#superclass : 'PjEqualsOptimization',
	#category : 'PharoJs-Base-Transpiler-Optimizations-Optimizations',
	#package : 'PharoJs-Base-Transpiler-Optimizations',
	#tag : 'Optimizations'
}

{ #category : 'converting' }
PjNotEqualsOptimization >> operator [
	^ #!=
]

{ #category : 'accessing' }
PjNotEqualsOptimization >> selector [
	^#~=
]

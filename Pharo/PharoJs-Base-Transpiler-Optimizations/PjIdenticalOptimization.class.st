Class {
	#name : 'PjIdenticalOptimization',
	#superclass : 'PjComparisonOptimization',
	#category : 'PharoJs-Base-Transpiler-Optimizations-Optimizations',
	#package : 'PharoJs-Base-Transpiler-Optimizations',
	#tag : 'Optimizations'
}

{ #category : 'converting' }
PjIdenticalOptimization >> operator [
	^ #===
]

{ #category : 'accessing' }
PjIdenticalOptimization >> selector [
	^#==
]

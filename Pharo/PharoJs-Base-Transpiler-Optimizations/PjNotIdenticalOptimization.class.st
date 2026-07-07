Class {
	#name : 'PjNotIdenticalOptimization',
	#superclass : 'PjComparisonOptimization',
	#category : 'PharoJs-Base-Transpiler-Optimizations-Optimizations',
	#package : 'PharoJs-Base-Transpiler-Optimizations',
	#tag : 'Optimizations'
}

{ #category : 'converting' }
PjNotIdenticalOptimization >> operator [
	^ #!==
]

{ #category : 'accessing' }
PjNotIdenticalOptimization >> selector [
	^#~~
]

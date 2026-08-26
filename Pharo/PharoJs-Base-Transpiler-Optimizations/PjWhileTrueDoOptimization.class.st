Class {
	#name : 'PjWhileTrueDoOptimization',
	#superclass : 'PjWhileOptimization',
	#category : 'PharoJs-Base-Transpiler-Optimizations-Optimizations',
	#package : 'PharoJs-Base-Transpiler-Optimizations',
	#tag : 'Optimizations'
}

{ #category : 'converting' }
PjWhileTrueDoOptimization >> continueValue [
	^ true
]

{ #category : 'converting' }
PjWhileTrueDoOptimization >> selector [
	^ #whileTrue:
]

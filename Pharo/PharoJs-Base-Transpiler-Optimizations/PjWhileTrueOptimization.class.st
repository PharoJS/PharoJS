Class {
	#name : 'PjWhileTrueOptimization',
	#superclass : 'PjWhileOptimization',
	#category : 'PharoJs-Base-Transpiler-Optimizations-Optimizations',
	#package : 'PharoJs-Base-Transpiler-Optimizations',
	#tag : 'Optimizations'
}

{ #category : 'converting' }
PjWhileTrueOptimization >> continueValue [
	^ true
]

{ #category : 'converting' }
PjWhileTrueOptimization >> selector [
	^ #whileTrue
]

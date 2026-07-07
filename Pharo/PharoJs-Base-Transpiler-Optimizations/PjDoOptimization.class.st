Class {
	#name : 'PjDoOptimization',
	#superclass : 'PjOptionalMessageConversion',
	#category : 'PharoJs-Base-Transpiler-Optimizations-Optimizations',
	#package : 'PharoJs-Base-Transpiler-Optimizations',
	#tag : 'Optimizations'
}

{ #category : 'converting' }
PjDoOptimization >> convertReceiver: aRBMessageNode args: aCollection [
	self flag: #todo.
	^ nil
]

{ #category : 'optimizing' }
PjDoOptimization >> selector [
	^ #do:
]

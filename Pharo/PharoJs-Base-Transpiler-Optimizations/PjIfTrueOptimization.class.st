Class {
	#name : #PjIfTrueOptimization,
	#superclass : #PjIfTrueIfFalseOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjIfTrueOptimization >> convertReceiver: receiverNode args: aCollection [ 
	| test |
	aCollection first isOptimizableAsContionalBlock ifFalse: [ ^ nil ].
	self needsAllPaths ifTrue: [
		^super convertReceiver: receiverNode args: aCollection, { RBLiteralValueNode new}].
	test := self inExpressionDo: [self visit: receiverNode].
	^PjIfTrueNode 
		test: test
		whenTrue: (self visitInlineBlock: aCollection first)
]

{ #category : #accessing }
PjIfTrueOptimization >> selector [
	^#ifTrue:
]

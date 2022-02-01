Class {
	#name : #PjAndOptimization,
	#superclass : #PjIfTrueIfFalseOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjAndOptimization >> convertReceiver: receiverNode args: aCollection [ 
	| test |
	aCollection first isOptimizableAsContionalBlock ifFalse: [ ^ nil ].
	self needsAllPaths ifTrue: [
		^super convertReceiver: receiverNode args: aCollection, { RBLiteralValueNode value: false}].
	test := self inExpressionDo: [self visit: receiverNode].
	^PjIfTrueIfFalseNode 
		test: test
		whenTrue: (self visitInlineBlock: aCollection first)
		whenFalse: (PjLiteralValueNode value: false)
]

{ #category : #accessing }
PjAndOptimization >> selector [
	^#and:
]

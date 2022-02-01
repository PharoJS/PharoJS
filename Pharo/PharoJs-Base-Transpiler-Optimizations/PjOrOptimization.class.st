Class {
	#name : #PjOrOptimization,
	#superclass : #PjIfTrueIfFalseOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjOrOptimization >> convertReceiver: receiverNode args: aCollection [ 
	| test |
	aCollection first isOptimizableAsContionalBlock ifFalse: [ ^ nil ].
	self needsAllPaths ifTrue: [
		^super convertReceiver: receiverNode args: { RBLiteralValueNode value: true}, aCollection].
	test := self inExpressionDo: [self visit: receiverNode].
	^PjIfTrueIfFalseNode 
		test: test
		whenTrue: (PjLiteralValueNode value: true)
		whenFalse: (self visitInlineBlock: aCollection first)
]

{ #category : #accessing }
PjOrOptimization >> selector [
	^#or:
]

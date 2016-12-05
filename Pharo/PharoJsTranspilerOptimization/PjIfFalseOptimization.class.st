Class {
	#name : #PjIfFalseOptimization,
	#superclass : #PjIfTrueIfFalseOptimization,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjIfFalseOptimization >> convertReceiver: receiverNode args: aCollection [ 
	| test |
	aCollection first isOptimizableAsContionalBlock ifFalse: [ ^ nil ].
	self needsAllPaths ifTrue: [
		^super convertReceiver: receiverNode args: { RBLiteralNode value: nil }, aCollection].
	test := self inExpressionDo: [self visit: receiverNode].
	^PjIfTrueNode 
		test: test not
		whenTrue: (self visitInlineBlock: aCollection first)
]

{ #category : #accessing }
PjIfFalseOptimization >> selector [
	^#ifFalse:
]

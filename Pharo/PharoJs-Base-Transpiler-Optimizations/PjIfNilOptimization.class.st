Class {
	#name : #PjIfNilOptimization,
	#superclass : #PjIfNilIfNotNilOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #optimizing }
PjIfNilOptimization >> convertReceiver: receiverNode args: aCollection [
	aCollection first isOptimizableAsContionalBlock ifFalse: [ ^ nil ].
	self needsAllPaths ifTrue: [
		^ self withTemp: [: tempName | 
			| tempNode |
			tempNode := PjTemporaryNode named: tempName.
			(super  convertReceiver: (RBAssignmentNode variable: tempNode value: receiverNode) args: aCollection,{tempNode})
	]].
	^PjIfNilNode 
		test: (self inExpressionDo: [self visit: receiverNode])
		whenNil: (self visitInlineBlock: aCollection first).
]

{ #category : #accessing }
PjIfNilOptimization >> selector [
	^#ifNil:
]

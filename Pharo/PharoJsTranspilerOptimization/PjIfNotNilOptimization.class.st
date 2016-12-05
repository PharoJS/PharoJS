Class {
	#name : #PjIfNotNilOptimization,
	#superclass : #PjIfNilIfNotNilOptimization,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #optimizing }
PjIfNotNilOptimization >> convertReceiver: receiverNode args: aCollection [
	| notNilBlockNode variableId |
	aCollection first isOptimizableAsContionalBlock ifFalse: [ ^ nil ].
	self needsAllPaths ifTrue: [^super  convertReceiver: receiverNode args: {RBLiteralValueNode value: nil}, aCollection].
	notNilBlockNode := aCollection first.
	(notNilBlockNode isBlock and: [ notNilBlockNode arguments notEmpty ]) ifFalse: [
		^PjIfNotNilNode
			test: (self inExpressionDo: [self visit: receiverNode])
			whenNotNil: (self visitInlineBlock: notNilBlockNode)
	].
	variableId := notNilBlockNode arguments first name.
	^ PjIfNotNilNode
			test: (self inExpressionDo: [PjAssignNode
						target: (PjArgumentNode identifier: variableId)
						expression: (self visit: receiverNode)])
			whenNotNil: (self visitInlineBlock: notNilBlockNode)

]

{ #category : #accessing }
PjIfNotNilOptimization >> selector [
	^#ifNotNil:
]

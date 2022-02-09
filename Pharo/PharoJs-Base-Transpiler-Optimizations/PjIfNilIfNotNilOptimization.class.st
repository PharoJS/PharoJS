"
I handle optimizations of various flavors of ifNil:ifNotNil:
"
Class {
	#name : #PjIfNilIfNotNilOptimization,
	#superclass : #PjOptionalMessageConversion,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjIfNilIfNotNilOptimization >> convertReceiver: receiverNode args: aCollection [ 
	| notNilBlockNode |
	aCollection first isOptimizableAsContionalBlock ifFalse: [ ^ nil ].
	notNilBlockNode := aCollection second.
	notNilBlockNode isOptimizableAsContionalBlock ifFalse: [ ^ nil ].
	(notNilBlockNode isBlock and: [ notNilBlockNode arguments notEmpty ]) ifTrue: [ | temp |
		temp := notNilBlockNode arguments first name.
		self astConverter newTemp: temp.
		^ self
			test: (self inExpressionDo: [PjAssignNode
						target: (PjArgumentNode identifier: temp)
						expression: (self visit: receiverNode)])
			whenNotNil: (self visitInlineBlock: notNilBlockNode)
			whenNil: (self visitInlineBlock: aCollection first)
	].
	^ self
		test: (self inExpressionDo: [self visit: receiverNode])
		whenNotNil: (self visitInlineBlock: notNilBlockNode)
		whenNil: (self visitInlineBlock: aCollection first)
]

{ #category : #accessing }
PjIfNilIfNotNilOptimization >> selector [
	^#ifNil:ifNotNil:
]

{ #category : #optimizing }
PjIfNilIfNotNilOptimization >> test: aTest whenNotNil: whenNotAst whenNil: whenAst [
	(aTest class = PjUnaryNode and: [ aTest operator = #! ]) ifTrue: [
		^PjIfNilIfNotNilNode
			test: aTest expression
			whenNotNil: whenAst
			whenNil: whenNotAst
	].
	^PjIfNilIfNotNilNode
		test: aTest
		whenNotNil: whenNotAst
		whenNil: whenAst
]

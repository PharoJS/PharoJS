"
I handle optimizations of various flavors of ifTrue:ifFalse
"
Class {
	#name : #PjIfTrueIfFalseOptimization,
	#superclass : #PjOptionalMessageConversion,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjIfTrueIfFalseOptimization >> convertReceiver: receiverNode args: aCollection [ 
	| test first second |
	aCollection first isOptimizableAsContionalBlock ifFalse: [ ^ nil ].
	aCollection second isOptimizableAsContionalBlock ifFalse: [ ^ nil ].
	test := self inExpressionDo: [self visit: receiverNode].
	first := self visitInlineBlock: aCollection first.
	second := self visitInlineBlock: aCollection second.
	^PjIfTrueIfFalseNode 
		test: test
		whenTrue: first
		whenFalse: second
]

{ #category : #accessing }
PjIfTrueIfFalseOptimization >> selector [
	^#ifTrue:ifFalse:
]

Class {
	#name : #PjStringAppendOptimization,
	#superclass : #PjOptionalMessageConversion,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjStringAppendOptimization >> convertReceiver: receiver args: args [
	| left |
	self inExpressionDo: [
		left := self visit: receiver].
	left isClass: String ifNot: [ ^ nil ].
	^ (PjBinaryNode
			operator: #+
			left: left
			right: (self inExpressionDo: [self visit: args first])
		) myClass: String
]

{ #category : #accessing }
PjStringAppendOptimization >> selector [
	^#,
]

"
My subclasses are optimizations for all of the comparison operators, most of which can be used directly in Javascript as they given legitimate results (if not always  meaningful if the types are different).
"
Class {
	#name : #PjComparisonOptimization,
	#superclass : #PjOptionalMessageConversion,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjComparisonOptimization >> convertReceiver: receiver args: args [
	| left right |
	self inExpressionDo: [
		left := self visit: receiver.
		right := self visit: args first].
	(self isOkWith: left and: right) ifFalse: [ ^ nil ].
	^ PjBinaryNode operator: self operator left: left right: right
]

{ #category : #converting }
PjComparisonOptimization >> isOkWith: receiver and: arg [
	^ receiver isLiteralNode
]

{ #category : #converting }
PjComparisonOptimization >> operator [
	^ self selector
]

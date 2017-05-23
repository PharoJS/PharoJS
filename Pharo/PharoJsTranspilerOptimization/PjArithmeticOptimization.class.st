"
My subclasses are optimizations for all of the arithmetic operators
"
Class {
	#name : #PjArithmeticOptimization,
	#superclass : #PjOptionalMessageConversion,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjArithmeticOptimization >> convertReceiver: receiver args: args [
	| left right |
	self inExpressionDo: [
		left := self visit: receiver.
		right := self visit: args first].
	(self isOkWith: left and: right) ifFalse: [ ^ nil ].
	^ PjBinaryNode operator: self operator left: left right: right
]

{ #category : #converting }
PjArithmeticOptimization >> isOkWith: receiver and: arg [
	^ "receiver isLiteralNode or: [ arg isLiteralNode ]" true
]

{ #category : #converting }
PjArithmeticOptimization >> operator [
	^ self selector
]

Class {
	#name : #PjWhileOptimization,
	#superclass : #PjOptionalMessageConversion,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjWhileOptimization >> continueValue [
	self subclassResponsibility
]

{ #category : #converting }
PjWhileOptimization >> convertReceiver: receiver args: args [
	| test body |
	self astConverter isInExpression ifTrue: [ ^ nil ].
	receiver isBlock ifFalse: [ ^ nil ].
	args isNotEmpty ifTrue: [args first isBlock ifFalse: [ ^ nil ]].
	self inExpressionDo: [
		test := self visitInlineLoopBlock: receiver].
	self continueValue ifFalse: [ test := test not ].
	^ self handleReturn: [
		body := args size isZero ifTrue: [
				#()
			] ifFalse: [
				(self visitInlineLoopBlock: args first) expressions
			].
		PjWhileNode test: test body: body]
]

Class {
	#name : #PjTimesRepeatOptimization,
	#superclass : #PjOptionalMessageConversion,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjTimesRepeatOptimization >> convertReceiver: receiver args: args [
	| from to body fromName toName |
	self astConverter isInExpression ifTrue: [ ^ nil ].
	args last isBlock ifFalse: [ ^ nil ].
	self inExpressionDo: [
		fromName := self tempName.
		from := PjAssignNode
			target: (PjTempVariableNode identifier: fromName)
			expression: (PjLiteralValueNode value: 1).
		to := self visit: receiver.
		to constantOrZero = 0 ifTrue: [
			toName := self tempName.
			to := PjAssignNode
				target: (PjTempVariableNode identifier: toName)
				expression: to].
	].
	^ self handleReturn: [
		body := (self visitInlineLoopBlock: args last) expressions.
		toName ifNotNil: [self tempNameFree: toName].
		self tempNameFree: fromName.
		PjForLoopNode
			from: from
			to: to
			by: nil
			body: body ]
]

{ #category : #converting }
PjTimesRepeatOptimization >> selector [
	^ #timesRepeat:
]

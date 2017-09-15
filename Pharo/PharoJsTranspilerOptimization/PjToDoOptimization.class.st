Class {
	#name : #PjToDoOptimization,
	#superclass : #PjOptionalMessageConversion,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjToDoOptimization >> convertReceiver: receiver args: args [
	| from to by body toName byName |
	true ifTrue: [ ^ nil ].
	self astConverter isInExpression ifTrue: [ ^ nil ].
	args last isBlock ifFalse: [ ^ nil ].
	args last arguments size = 1 ifFalse: [ ^ nil ].
	self inExpressionDo: [
		from := PjAssignNode
			target: (PjArgumentNode identifier: args last arguments first name)
			expression: (self visit: receiver).
		to := self visit: args first.
		to constantOrZero = 0 ifTrue: [
			toName := self tempName.
			to := PjAssignNode
				target: (PjTempVariableNode identifier: toName)
				expression: to].
		args size = 3 ifTrue: [
			by := self visit: args second.
			by constantOrZero = 0 ifTrue: [
				byName := self tempName.
				by := PjAssignNode
					target: (PjTempVariableNode identifier: byName)
					expression: by]
	]].
	^ self handleReturn: [
		body := (self visitInlineLoopBlock: args last) expressions.
		byName ifNotNil: [self tempNameFree: byName].
		toName ifNotNil: [self tempNameFree: toName].
		PjForLoopNode
			from: from
			to: to
			by: by
			body: body ]
]

{ #category : #converting }
PjToDoOptimization >> selector [
	^ #to:do:
]

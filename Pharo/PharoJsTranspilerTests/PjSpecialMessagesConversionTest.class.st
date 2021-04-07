"
I have tests for ast conversions that use the optimizer.
"
Class {
	#name : #PjSpecialMessagesConversionTest,
	#superclass : #PjAstConverterTest,
	#instVars : [
		'messageConverter'
	],
	#category : #'PharoJsTranspilerTests-Tests'
}

{ #category : #running }
PjSpecialMessagesConversionTest >> setUp [
	super setUp.
	messageConverter := converter messageConverter.
]

{ #category : #testing }
PjSpecialMessagesConversionTest >> testCascade [
	| temp assignment |
	messageConverter addAllConversions: { PjJsAtConversion. PjJsAtPutConversion}.
	temp := PjTempVariableNode identifier: '$1'.
	assignment := PjAssignNode
		target: temp
		expression: (PjApplyNode
				func: (PjFieldNode
						target: (PjApplyNode receiver: selfNode selector: #testCascade args: #())
						selectorNode: nil
						isNonNil: false)
				args: nil).
	self
		assertContentsOf: [ self testCascade js_at:  1; js_at:  3 put: 1; js_at:  2 ]
		convertsTo: (PjSequenceNode expressions: {
				assignment.
				PjFieldNode target:  temp selectorNode: one isNonNil: true.
				PjAssignNode target: (PjFieldNode target:  temp selectorNode: three isNonNil: true) expression: one.
				PjFieldNode target:  temp selectorNode: two isNonNil: true.
			})
]

{ #category : #testing }
PjSpecialMessagesConversionTest >> testJsAt [
	messageConverter addConversion: PjJsAtConversion.
	self assertContentsOf: [ self js_at:  3 ] convertsTo: (PjFieldNode target: selfNode selectorNode: three isNonNil: true)
]

{ #category : #testing }
PjSpecialMessagesConversionTest >> testJsAtPut [
	messageConverter addConversion: PjJsAtPutConversion.
	self assertContentsOf: [ self js_at:  3 put: 2] convertsTo: (PjAssignNode target: (PjFieldNode target: selfNode selectorNode: three isNonNil: true) expression: two)
]

{ #category : #testing }
PjSpecialMessagesConversionTest >> testJsThis [
	messageConverter addConversion: PjJsThisConversion.
	self assertContentsOf: [ self js_this ] convertsTo: (PjGlobalNode identifier: #this)
]

{ #category : #testing }
PjSpecialMessagesConversionTest >> testMessageConversionPerformed [
	messageConverter addAllConversions: (#(2 6 4) collect: [ : i | PjNullMessageConversionForTest new order: i selector: #foo]).
	self assertContentsOf: [ 3 foo ] convertsTo: 4.
]

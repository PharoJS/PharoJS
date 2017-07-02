"
I have tests for ast conversions that use the optimizer.
"
Class {
	#name : #PjSpecialMessagesConversionTest,
	#superclass : #PjAstConverterTest,
	#instVars : [
		'messageConverter'
	],
	#category : #'PharoJsTranspiler-Tests'
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

{ #category : #testing }
PjSpecialMessagesConversionTest >> testMethodCond1 [
	| expectedAst |
	messageConverter addAllConversions: {PjIfTrueIfFalseOptimization. PjIfFalseIfTrueOptimization. PjNotOptimization}.
	expectedAst := PjMethodNode parameters:{} locals:{#bar} body:{
		PjApplyNode
			func:(	PjFieldNode
				target:(PjApplyNode
					func:(PjFieldNode target:PjSelfNode new selectorNode:(PjMessageSelectorNode identifier:#foo) isNonNil:true)
					args:{})
				selectorNode:(PjMessageSelectorNode identifier:#ifTrue:ifFalse:)
				isNonNil:false)
			args:{
				PjBlockNode parameters:{} locals:{} body:{
					PjAssignNode
						target:(PjTempVariableNode identifier:#bar)
						expression:(PjLiteralValueNode value:4).
					PjReturnNode expression:(PjApplyNode
						func:(PjFieldNode
							target:(PjApplyNode
								func:(PjFieldNode target:(PjTempVariableNode identifier:#bar) selectorNode:(PjMessageSelectorNode identifier:#isNil) isNonNil:false)
								args:{})
							selectorNode:(PjMessageSelectorNode identifier:#ifTrue:ifFalse:) isNonNil:false)
						args:{PjBlockNode parameters:{} locals:{} body:{
							PjReturnNode expression:(
								PjApplyNode func:(PjFieldNode
									target:PjSelfNode new selectorNode:(PjMessageSelectorNode identifier:#foo) isNonNil:true)
									args:{})}.
							PjBlockNode parameters:{} locals:{} body:{
								PjReturnNode expression:(PjApplyNode
									func:(PjFieldNode target:PjSelfNode new selectorNode:(PjMessageSelectorNode identifier:#bar) isNonNil:true)
									args:{})}
							}
					)}.
				PjBlockNode parameters:{} locals:{} body:{
					PjReturnNode expression:(PjAssignNode
						target:(PjTempVariableNode identifier:#bar)
						expression:PjNilNode new)}}.
		PjReturnNode expression:(PjApplyNode
				func:(PjFieldNode
					target:(PjTempVariableNode identifier:#bar) selectorNode:(PjMessageSelectorNode identifier:#value:) isNonNil:false)
				args:{PjLiteralValueNode value:2})
		} methodName:#cond1 needsSelf:true isClassMethod:false.
		
	expectedAst := PjMethodNode parameters:{} locals:{#bar} body:{
		PjIfTrueIfFalseNode
			test:(PjApplyNode func:(PjFieldNode target:PjSelfNode new selectorNode:(PjMessageSelectorNode identifier:#foo) isNonNil:true) args:{})
			whenTrue:(
				PjSequenceNode expressions:{
					PjAssignNode
						target:(PjTempVariableNode identifier:#bar)
						expression:(PjLiteralValueNode value:4).
					PjIfTrueIfFalseNode
						test:(
							PjApplyNode
								func:(PjFieldNode target:(PjTempVariableNode identifier:#bar) selectorNode:(PjMessageSelectorNode identifier:#isNil) isNonNil:false)
								args:{})
						whenTrue:(
							PjApplyNode
								func:(PjFieldNode target:PjSelfNode new selectorNode:(PjMessageSelectorNode identifier:#foo) isNonNil:true)
								args:{})
						whenFalse:(
							PjApplyNode
								func:(PjFieldNode
									target:PjSelfNode new selectorNode:(PjMessageSelectorNode identifier:#bar) isNonNil:true) args:{})})
			whenFalse:(
				PjAssignNode
					target:(
						PjTempVariableNode identifier:#bar)
					expression:PjNilNode new).
		PjReturnNode expression:(
			PjApplyNode
				func:(PjFieldNode target:(PjTempVariableNode identifier:#bar) selectorNode:(PjMessageSelectorNode identifier:#value:) isNonNil:false)
				args:{PjLiteralValueNode value:2})
		} methodName:#cond1 needsSelf:false isClassMethod:false.

	self assertMethod: #cond1 convertsTo: expectedAst
]

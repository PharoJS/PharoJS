"
I have tests for basic ast conversions
"
Class {
	#name : #PjBasicConverterTest,
	#superclass : #PjAstConverterTest,
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #'test mock' }
PjBasicConverterTest >> addPoolReference: aClass [ 
	^ 'mock$'
]

{ #category : #testing }
PjBasicConverterTest >> testArray [
	| x |
	x := PjTempVariableNode identifier: #x.
	self assertContentsOf: [ {1. 2. x foo} ] convertsTo: (PjArrayNode expressions: { one. two. self apply: x selector: #foo }).
	self assertContentsOf: [ #(1 2 x) ] convertsTo: (PjArrayNode expressions: { one. two. PjLiteralValueNode value: #x })
]

{ #category : #testing }
PjBasicConverterTest >> testBlockBasics [
	| expectedAst  xVariable assignment returnAssignment blockReturningOne |
	self assertContentsOf: [ nil ] convertsTo: nilNode.
	
	expectedAst := self simpleBlock: returnNil.
	self assertContentsOf: [ [  ] ] convertsTo: expectedAst.
	
	expectedAst := PjBlockNode 
		parameters: #(a1 a2) 
		locals: #(t1 t2 t3)
		body: {returnNil}.
	self assertContentsOf: [ [: a1 : a2|  |t1 t2 t3|] ] convertsTo: expectedAst.

	expectedAst := self simpleBlock: returnOne.
	self assertContentsOf: [ [ 1 ] ] convertsTo: expectedAst.

	xVariable := PjTempVariableNode identifier: #x.
	assignment := PjAssignNode target: xVariable expression:  two.
	returnAssignment := PjReturnNode expression: assignment. 
	expectedAst := PjBlockNode 
		parameters: #() 
		locals: #(x)
		body: {returnAssignment}.
	self assertContentsOf: [ [ |x| x := 2 ] ] convertsTo: expectedAst.
	
	blockReturningOne := PjBlockNode 
		parameters: #() 
		locals: #() 
		body: {one.returnOne}.
	expectedAst := PjBlockNode 
		parameters: #() 
		locals: #() 
		body: {blockReturningOne. returnOne}.
	self assertContentsOf: [ [ [1. 1]. 1 ] ] convertsTo: expectedAst.

]

{ #category : #testing }
PjBasicConverterTest >> testBlockNonLocalReturns [
	| expectedAst innerBlockAst |

	expectedAst := self simpleBlock: {throwOne}.
	self assertContentsOf: [ [ ^1 ] ] convertsTo: expectedAst.

	innerBlockAst := self simpleBlock: {throwTwo}.
	expectedAst := self simpleBlock: {innerBlockAst. throwOne}.
	self assertContentsOf:  [ [[ ^2 ]. ^1 ]]  convertsTo: expectedAst.

	converter preventNonLocalReturns.
	self failConverting: [ [ ^1 ] ].
	self failConverting: [ [ [^2] ] ].
	self failConverting: [ [ []. [^2] ] ].

]

{ #category : #testing }
PjBasicConverterTest >> testBlockRelatedFlags [
	self deny: converter isInBlock.
	self deny: converter hasInBlockSelfReferences.
	self deny: converter hasNonLocalReturns.

	self convertFirstStatementOfBlock: [ [self ] ].
	self assert: converter hasInBlockSelfReferences.
	self deny: converter isInBlock.
	self deny: converter hasNonLocalReturns.
	
	self convertFirstStatementOfBlock: [ [^1 ] ].
	self deny: converter hasInBlockSelfReferences.
	self deny: converter isInBlock.
	self assert: converter hasNonLocalReturns.

	self convertFirstStatementOfBlock: [ [1 ] ].
	self deny: converter hasInBlockSelfReferences.
	self deny: converter isInBlock.
	self deny: converter hasNonLocalReturns.




]

{ #category : #testing }
PjBasicConverterTest >> testBlockReturns [
	| expectedAst innerBlockAst |

	expectedAst := self simpleBlock: {three. two. returnOne}.
	self assertContentsOf: [ [ 3. 2. 1 ] ] convertsTo: expectedAst.

	innerBlockAst := self simpleBlock: {returnOne}.
	expectedAst := self simpleBlock: {three. two. (PjReturnNode expression: innerBlockAst)}.
	self assertContentsOf: [ [ 3. 2. [1] ] ] convertsTo: expectedAst.

	innerBlockAst := self simpleBlock: throwOne.
	expectedAst := self simpleBlock: {three. two. (PjReturnNode expression: innerBlockAst)}.
	self assertContentsOf: [ [ 3. 2. [^1] ] ] convertsTo: expectedAst.

]

{ #category : #testing }
PjBasicConverterTest >> testExpressionNonLocalReturns [
	| expectedAst  |
	expectedAst := PjArrayNode expressions: {throwOne}.
	self assertContentsOf: [ { ^1 } ] convertsTo: expectedAst.

	converter preventNonLocalReturns.
	self failConverting: [ { ^1 } ].

]

{ #category : #testing }
PjBasicConverterTest >> testInteger [
	self assertContentsOf: [ 1 ] convertsTo: one
]

{ #category : #testing }
PjBasicConverterTest >> testLiteralArrayOfIntegers [
	| literalNodes |
	literalNodes := #(3 5 21) collect: [ : each | PjLiteralValueNode value: each ].
	self assertContentsOf: [ #(3 5 21) ] convertsTo: (PjArrayNode expressions: literalNodes)
]

{ #category : #testing }
PjBasicConverterTest >> testMessageWithoutOptimizationManager [
	| expectedAst |
	expectedAst := self apply: three selector: #foo.
	self assertContentsOf: [ 3 foo ] convertsTo: expectedAst.
]

{ #category : #testing }
PjBasicConverterTest >> testMethodBasic1 [
	| expectedAst |
	expectedAst := PjMethodNode
		methodName: #basic1
		body:
			{one.
			returnSelf}.
	self assertMethod: #basic1 convertsTo: expectedAst
]

{ #category : #testing }
PjBasicConverterTest >> testMethodBasic2 [
	| expectedAst |
	expectedAst := PjMethodNode
		methodName: #basic2
		body: {returnOne}.
	self assertMethod: #basic2 convertsTo: expectedAst
]

{ #category : #testing }
PjBasicConverterTest >> testMethodBasic3 [
	| expectedBody expectedAst |
	expectedBody := {(PjUnparsedStringNode string: 'return 3')}.
	expectedAst := PjMethodNode
		methodName: #basic3
		body: expectedBody.
	self assertMethod: #basic3 convertsTo: expectedAst
]

{ #category : #testing }
PjBasicConverterTest >> testMethodBasic4 [
	| expectedBody expectedAst |
	expectedBody := {three.
	(self
		simpleBlock:
			{two.
			returnOne}).
	returnSelf}.
	expectedAst := PjMethodNode
		methodName: #basic4
		body: expectedBody.
	self assertMethod: #basic4 convertsTo: expectedAst
]

{ #category : #testing }
PjBasicConverterTest >> testMethodBasic5 [
	| expectedBody expectedAst |
	expectedBody := {three.
	(PjReturnNode
		expression:
			(self
				simpleBlock:
					{two.
					returnOne}))}.
	expectedAst := PjMethodNode
		methodName: #basic5
		body: expectedBody.
	self assertMethod: #basic5 convertsTo: expectedAst
]

{ #category : #testing }
PjBasicConverterTest >> testMethodBasic6 [
	| expectedBody expectedAst |
	expectedBody := {(self
		simpleBlock:
			{two.
			returnOne}).
	three.
	returnSelf}.
	expectedAst := PjMethodNode
		methodName: #basic6
		body: expectedBody.
	self assertMethod: #basic6 convertsTo: expectedAst
]

{ #category : #testing }
PjBasicConverterTest >> testReadWriteClassVariables [
	| astAssignment classVar |
	converter classForConversion: PjAstTests.
	classVar := (PjClassVariableNode identifier: #ClassVarForTest) poolReference: PjAstTests;myClass: PjAstTests.
	self assertContentsOf: [ ClassVarForTest ] convertsTo: classVar.
	astAssignment := PjAssignNode 
		target:  classVar
		expression: classVar.
	self assertContentsOf: [ ClassVarForTest := ClassVarForTest ] convertsTo: astAssignment.
]

{ #category : #testing }
PjBasicConverterTest >> testReadWriteInstanceVariables [
	| astAssignment |
	self assertContentsOf: [ iv1ForTest ] convertsTo: (PjFieldNode target: selfNode selectorNode: iv1ForTest isNonNil: true).
	astAssignment := PjAssignNode 
		target:  (PjFieldNode target: selfNode selectorNode: iv1ForTest isNonNil: true) 
		expression: (PjFieldNode target: selfNode selectorNode: iv2ForTest isNonNil: true).
	self assertContentsOf: [ iv1ForTest := iv2ForTest ] convertsTo: astAssignment.
]

{ #category : #testing }
PjBasicConverterTest >> testReadWriteVariable [
	| astAssignment |
	self assertContentsOf: [ |x| x ] convertsTo: (PjTempVariableNode identifier: #x).
	astAssignment := PjAssignNode 
		target:  (PjTempVariableNode identifier: #x) 
		expression: (PjTempVariableNode identifier: #y).
	self assertContentsOf: [ |x y| x := y ] convertsTo: astAssignment.
]

{ #category : #testing }
PjBasicConverterTest >> testSelf [
	self assertContentsOf: [ self ] convertsTo: selfNode
]

{ #category : #testing }
PjBasicConverterTest >> testSpecialVariables [
	| expectedAst |
	expectedAst := self apply: (PjClassNode identifier: #Number) selector: #one.
	self assertContentsOf: [ Number one ] convertsTo: expectedAst.

	expectedAst := self apply: PjSuperNode new selector: #value.
	self assertContentsOf: [ super value ] convertsTo: expectedAst.

	self failConverting: [ thisContext  ]
]

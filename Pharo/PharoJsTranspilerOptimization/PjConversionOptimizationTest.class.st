Class {
	#name : #PjConversionOptimizationTest,
	#superclass : #PjSpecialMessagesConversionTest,
	#category : #'PharoJsTranspilerOptimization-Tests'
}

{ #category : #testing }
PjConversionOptimizationTest >> assertUnoptimizedContentsOf: aBlock [
	| actualJsAst |
	actualJsAst := self convertFirstStatementOfBlock: aBlock.
	self assert: actualJsAst class = PjApplyNode
]

{ #category : #testing }
PjConversionOptimizationTest >> testAnd [
	| expectedAst y returnAst |
	y := PjTempVariableNode identifier: #y.
	messageConverter addAllConversions: {PjAndOptimization}. 
	expectedAst := PjIfTrueIfFalseNode 
		test: y
		whenTrue: one
		whenFalse: falseNode.
	returnAst := PjIfTrueIfFalseNode 
		test: y
		whenTrue: returnOne
		whenFalse: returnFalse.
	self assertContentsOf: [ ^ y and: [1]] convertsTo: returnAst.
	self assertContentsOf: [ ^ y and: 1] convertsTo: returnAst.
	self assertContentsOf: [ y and: [1]] convertsTo: expectedAst.
	self assertContentsOf: [ y and: 1] convertsTo: expectedAst.
	
]

{ #category : #testing }
PjConversionOptimizationTest >> testBlockReturns [
	| expectedAst tempId temp xArg |
	messageConverter
		addAllConversions:
			{PjIfNilOptimization.
			PjIfNotNilOptimization.
			PjIfTrueOptimization.
			PjIfTrueIfFalseOptimization}.
	expectedAst := self
		simpleBlock:
			{three.
			two.
			(PjIfTrueIfFalseNode
				test: one
				whenTrue: returnOne
				whenFalse: returnNil)}
		locals: #().
	self
		assertContentsOf: [ [ 3.
			2.
			1
				ifTrue: [ 1 ] ] ]
		convertsTo: expectedAst.
	expectedAst := self
		simpleBlock:
			{three.
			two.
			(PjIfTrueIfFalseNode
				test: one
				whenTrue: throwTwo
				whenFalse: throwOne)}
		locals: #().
	self
		assertContentsOf: [ [ 3.
			2.
			^ 1
				ifTrue: [ 2 ]
				ifFalse: [ 1 ] ] ]
		convertsTo: expectedAst.
	expectedAst := self
		simpleBlock:
			{three.
			two.
			(PjIfNilIfNotNilNode
				test: one
				whenNotNil: throwOne
				whenNil: throwNil)}
		locals: #().
	self
		assertContentsOf: [ [ 3.
			2.
			^ 1 ifNotNil: [ 1 ] ] ]
		convertsTo: expectedAst.
	xArg := PjArgumentNode identifier: #x.
	expectedAst := self
		simpleBlock:
			{three.
			two.
			(PjIfNilIfNotNilNode
				test: (PjAssignNode target: xArg expression: one)
				whenNotNil: (PjNonLocalReturnNode expression: xArg)
				whenNil: throwNil)}
		locals: #(x).
	self
		assertContentsOf: [ [ 3.
			2.
			^ 1 ifNotNil: [ :x | x ] ] ]
		convertsTo: expectedAst.
	tempId := '$1'.
	temp := PjTempVariableNode identifier: tempId asSymbol.
	expectedAst := self
		simpleBlock:
			{three.
			two.
			(PjIfNilIfNotNilNode
				test: (PjAssignNode target: temp expression: one)
				whenNotNil: (PjReturnNode expression: temp)
				whenNil: returnOne)}
		locals: #('$1').
	self
		assertContentsOf: [ [ 3.
			2.
			1 ifNil: [ 1 ] ] ]
		convertsTo: expectedAst.
	expectedAst := self
		simpleBlock:
			{three.
			two.
			(PjIfNilIfNotNilNode
				test: (PjAssignNode target: temp expression: one)
				whenNotNil: (PjNonLocalReturnNode expression: temp)
				whenNil: throwOne)}
		locals: #('$1').
	self
		assertContentsOf: [ [ 3.
			2.
			^ 1 ifNil: [ 1 ] ] ]
		convertsTo: expectedAst
]

{ #category : #testing }
PjConversionOptimizationTest >> testBlockReturns1 [
	| expectedAst |
	messageConverter
		addAllConversions:
			{PjIfNilOptimization.
			PjIfNotNilOptimization.
			PjIfTrueOptimization.
			PjIfTrueIfFalseOptimization}.
	expectedAst := self
		simpleBlock: {three. two. (PjIfTrueIfFalseNode test: one whenTrue: returnTwo whenFalse: returnOne)}
		locals: #().
	self 
		assertContentsOf: [ [ 3. 2. 1 ifTrue: [ 2 ] ifFalse: [ 1 ] ] ]
		convertsTo: expectedAst.
	expectedAst := self
		simpleBlock: {three. two. (PjIfTrueIfFalseNode test: one whenTrue: throwTwo whenFalse: returnOne)}
		locals: #().
	self
		assertContentsOf: [ [ 3. 2. 1 ifTrue: [ ^ 2 ] ifFalse: [ 1 ] ] ]
		convertsTo: expectedAst.
	expectedAst := self
		simpleBlock: {PjIfTrueIfFalseNode test: one whenTrue: two whenFalse: one. returnTwo}
		locals: #().
	self
		assertContentsOf: [ [ 1 ifTrue: [ 2 ] ifFalse: [ 1 ]. 2 ] ]
		convertsTo: expectedAst.
	expectedAst := self
		simpleBlock: {three. two. (PjIfTrueIfFalseNode test: (PjIfTrueIfFalseNode test: one whenTrue: two whenFalse: one) whenTrue: returnTwo whenFalse: returnOne)}
		locals: #().
	self
		assertContentsOf: [ [ 3. 2. (1 ifTrue: [ 2 ] ifFalse: [ 1 ]) ifTrue: [ 2 ] ifFalse: [ 1 ] ] ]
		convertsTo: expectedAst.

]

{ #category : #testing }
PjConversionOptimizationTest >> testComparisons [
	| y x |
	y := PjTempVariableNode identifier: #y.
	x := PjTempVariableNode identifier: #x.
	messageConverter addAllConversions: PjComparisonOptimization allSubclasses.
	self assertContentsOf: [ x=y ]
			convertsTo: (PjApplyNode receiver: x selector: #= args: {y}).
	self assertContentsOf: [ 1=y ] convertsTo: (PjBinaryNode operator: #== left: one right: y).
	self assertContentsOf: [ x='foo' ] convertsTo: (PjBinaryNode operator: #== left: x right: foo).
	self assertContentsOf: [ x~=y ]
			convertsTo: (PjApplyNode receiver: x selector: #~= args: {y}).
	self assertContentsOf: [ 1<=y ] convertsTo: (PjBinaryNode operator: #<= left: one right: y).
	self assertContentsOf: [ 'hello'<=y ] convertsTo: (PjBinaryNode operator: #<= left: helloString right: y).
	self assertContentsOf: [ x<=y ] convertsTo: (PjApplyNode func:(PjFieldNode target:(PjTempVariableNode identifier:#x) selectorNode:(PjMessageSelectorNode identifier:#'<=') isNonNil:false) args:{PjTempVariableNode identifier:#y}).
	self assertContentsOf: [ x~~y ] convertsTo: (PjBinaryNode operator: #!== left: x right: y).
	self assertContentsOf: [ x==y ] convertsTo: (PjBinaryNode operator: #=== left: x right: y).
	self assertContentsOf: [ 1~=y ] convertsTo: (PjBinaryNode operator: #!= left: one right: y).

]

{ #category : #testing }
PjConversionOptimizationTest >> testIfFalse [
	| expectedAst y returnAst |
	y := PjTempVariableNode identifier: #y.
	messageConverter addAllConversions: {PjIfFalseOptimization}. 
	expectedAst := PjIfTrueNode 
		test: y not
		whenTrue: one.
	returnAst := PjIfTrueIfFalseNode 
		test: y
		whenTrue: returnNil
		whenFalse: returnOne.
	self assertContentsOf: [ ^ y ifFalse: [1]] convertsTo: returnAst.
	self assertContentsOf: [ ^ y ifFalse: 1] convertsTo: returnAst.
	self assertContentsOf: [ y ifFalse: [1]] convertsTo: expectedAst.
	self assertContentsOf: [ y ifFalse: 1] convertsTo: expectedAst.
	
]

{ #category : #testing }
PjConversionOptimizationTest >> testIfFalseifTrue [
	| expectedAst y |
	y := PjTempVariableNode identifier: #y.
	messageConverter addAllConversions: {PjIfFalseIfTrueOptimization. PjNotOptimization}.
	expectedAst := PjIfTrueIfFalseNode 
		test: y
		whenTrue: one 
		whenFalse: two. 
	self assertContentsOf: [ y ifFalse: [2] ifTrue: [1]] convertsTo: expectedAst.
	self assertContentsOf: [ y ifFalse: 2 ifTrue: 1] convertsTo: expectedAst.

	expectedAst := PjIfTrueIfFalseNode 
		test: y not
		whenTrue: one
		whenFalse: two. 
	self assertContentsOf: [ y not ifFalse: [2] ifTrue: [1]] convertsTo: expectedAst.
	self assertContentsOf: [ y not ifFalse: 2 ifTrue: 1] convertsTo: expectedAst.
	
]

{ #category : #testing }
PjConversionOptimizationTest >> testIfNil [
	| expectedAst tempVariable tempVariableName y |
	y := PjTempVariableNode identifier: #y.
	messageConverter addAllConversions: {PjIfNilOptimization}.
	tempVariableName := PjStringGenerator tempNamePrefix , '1'.
	tempVariable := PjTempVariableNode
		identifier: tempVariableName asSymbol.
	expectedAst := PjIfNilIfNotNilNode
		test:
			(PjAssignNode
				target: tempVariable
				expression: (self apply: y selector: #foo))
		whenNotNil: (PjReturnNode expression: tempVariable)
		whenNil: returnOne.
	self
		assertContentsOf: [ ^ y foo ifNil: [ 1 ] ]
		convertsTo: expectedAst.
	expectedAst := self simpleBlock: expectedAst locals: #('$1').
	self
		assertContentsOf: [ [ y foo ifNil: [ 1 ] ] ]
		convertsTo: expectedAst.
	expectedAst := PjIfNilIfNotNilNode
		test:
			(PjAssignNode
				target: tempVariable
				expression: (self apply: y selector: #foo))
		whenNotNil: (PjNonLocalReturnNode expression: tempVariable)
		whenNil: throwOne.
	expectedAst := self simpleBlock: expectedAst locals: #('$1').
	self
		assertContentsOf: [ [ ^ y foo ifNil: [ 1 ] ] ]
		convertsTo: expectedAst.
	expectedAst := PjIfNilNode
		test: (self apply: y selector: #foo)
		whenNil: one.
	self assertContentsOf: [ y foo ifNil: [ 1 ] ] convertsTo: expectedAst
]

{ #category : #testing }
PjConversionOptimizationTest >> testIfNilIfNotNil [
	| expectedAst y |
	y := PjTempVariableNode identifier: #y.
	messageConverter addAllConversions: {PjIfNilIfNotNilOptimization}. 
	expectedAst := PjIfNilIfNotNilNode 
		test: y
		whenNotNil: two
		whenNil: one. 
	self assertContentsOf: [ y ifNil: [1] ifNotNil: [2]] convertsTo: expectedAst.
	self assertContentsOf: [ y ifNil: 1 ifNotNil: 2] convertsTo: expectedAst.
	
	expectedAst := PjIfNilIfNotNilNode 
		test: (PjAssignNode
			target: (PjArgumentNode identifier: #x)
			 expression: y) 
		whenNotNil: (PjArgumentNode identifier: #x)
		whenNil: one.
	self assertContentsOf: [ y ifNil: [1 ] ifNotNil: [: x | x]] convertsTo: expectedAst.
]

{ #category : #testing }
PjConversionOptimizationTest >> testIfNotNil [
	| expectedAst y |
	y := PjTempVariableNode identifier: #y.
	messageConverter addAllConversions: {PjIfNotNilOptimization}.

	expectedAst := PjIfNotNilNode
		test: y
		whenNotNil: one. 
	self assertContentsOf: [y ifNotNil: [1]] convertsTo: expectedAst.

	expectedAst := PjIfNotNilNode 
		test: (PjAssignNode
			target: (PjArgumentNode identifier: #x)
			 expression: y)
		whenNotNil: (PjArgumentNode identifier: #x).
	self assertContentsOf: [y ifNotNil: [: x | x]] convertsTo: expectedAst.

	expectedAst := PjIfNilIfNotNilNode 
		test: y
		whenNotNil: returnOne
		whenNil:  returnNil. 
	self assertContentsOf: [ ^ y ifNotNil: [1]] convertsTo: expectedAst.

	expectedAst := PjIfNilIfNotNilNode 
		test: (PjAssignNode
			target: (PjArgumentNode identifier: #x)
			 expression: y)
		whenNotNil: (PjReturnNode expression: (PjArgumentNode identifier: #x))
		whenNil: returnNil.
	self assertContentsOf: [ ^ y ifNotNil: [: x | x]] convertsTo: expectedAst.

]

{ #category : #testing }
PjConversionOptimizationTest >> testIfNotNilifNil [
	| expectedAst y |
	y := PjTempVariableNode identifier: #y.
	messageConverter addAllConversions: {PjIfNotNilIfNilOptimization. PjNotOptimization}. 
	expectedAst := PjIfNilIfNotNilNode 
			test:  (self apply: y selector: #foo)
			whenNotNil: returnOne
			whenNil: returnNil.
	self assertContentsOf: [ ^y foo ifNotNil: [1] ifNil: []] convertsTo: expectedAst.

	expectedAst := PjIfNilIfNotNilNode 
			test:  (self apply: y selector: #foo)
			whenNotNil: (PjAssignNode target: y expression: one)
			whenNil: (PjAssignNode target: y expression: two).
	self assertContentsOf: [
			y foo ifNotNil: [
				y:=1
			] ifNil: [
				y:=2
			]] convertsTo: expectedAst
]

{ #category : #testing }
PjConversionOptimizationTest >> testIfTrue [
	| expectedAst y returnAst |
	y := PjTempVariableNode identifier: #y.
	messageConverter addAllConversions: {PjIfTrueOptimization}. 
	expectedAst := PjIfTrueNode 
		test: y
		whenTrue: one.
	returnAst := PjIfTrueIfFalseNode 
		test: y
		whenTrue: returnOne
		whenFalse: returnNil.
	self assertContentsOf: [ y ifTrue: [1]] convertsTo: expectedAst.
	self assertContentsOf: [ y ifTrue: 1] convertsTo: expectedAst.
	self assertContentsOf: [ ^ y ifTrue: [1]] convertsTo: returnAst.
	self assertContentsOf: [ ^ y ifTrue: 1] convertsTo: returnAst.
	expectedAst := PjIfTrueNode 
		test: y
		whenTrue: (PjSequenceNode expressions: {one. two}).
	self assertContentsOf: [ y ifTrue: [1. 2.] ] convertsTo: expectedAst.
	
]

{ #category : #testing }
PjConversionOptimizationTest >> testIfTrueIfFalse [
	| expectedAst y returnAst |
	y := PjTempVariableNode identifier: #y.
	messageConverter addAllConversions: {PjIfTrueIfFalseOptimization}. 
	expectedAst := PjIfTrueIfFalseNode 
		test: y
		whenTrue: one 
		whenFalse: two.
	returnAst := PjIfTrueIfFalseNode 
		test: y
		whenTrue: returnOne
		whenFalse: returnTwo.
	self assertContentsOf: [ y ifTrue: [1] ifFalse: [2]] convertsTo: expectedAst.
	self assertContentsOf: [ y ifTrue: 1 ifFalse: 2] convertsTo: expectedAst.
	self assertContentsOf: [ ^ y ifTrue: [1] ifFalse: [2]] convertsTo: returnAst.
	self assertContentsOf: [ ^ y ifTrue: 1 ifFalse: 2] convertsTo: returnAst.

]

{ #category : #testing }
PjConversionOptimizationTest >> testInlineBlockReturns [
	| expectedAst |
	messageConverter
		addAllConversions:
			{PjIfTrueOptimization.
			PjIfTrueIfFalseOptimization}.
	expectedAst := self
		simpleBlock:
			{(PjIfTrueIfFalseNode
				test: one
				whenTrue:
					(PjSequenceNode
						expressions:
							{two.
							returnThree})
				whenFalse:
					(PjReturnNode
						expression:
							(self
								simpleBlock:
									{two.
									returnThree}
								locals: #())))}
		locals: #().
	self
		assertContentsOf: [ [ 1
				ifTrue: [ 2.
					3 ]
				ifFalse: [ [ 2.
					3 ] ] ] ]
		convertsTo: expectedAst.
	expectedAst := self
		simpleBlock:
			{(PjIfTrueIfFalseNode
				test: one
				whenTrue:
					(PjSequenceNode
						expressions:
							{two.
							three})
				whenFalse:
					(PjSequenceNode
						expressions:
							{one.
							(self
								simpleBlock:
									{two.
									returnThree}
								locals: #())})).
			returnOne}
		locals: #().
	self
		assertContentsOf: [ [ 1
				ifTrue: [ 2.
					3 ]
				ifFalse: [ 1.
					[ 2.
					3 ] ].
			1 ] ]
		convertsTo: expectedAst
]

{ #category : #testing }
PjConversionOptimizationTest >> testInlineBlockTempvars [
	| expectedAst block |
	messageConverter
		addAllConversions: {PjIfTrueOptimization.PjTimesRepeatOptimization}.
	block := [ [ self ifTrue: [ |w| w ] ] ].
	expectedAst := PjBlockNode parameters:{} locals:{#w} body:{
		PjIfTrueIfFalseNode test: (PjSelfNode new inBlock: true)
			whenTrue:(PjReturnNode expression:(PjTempVariableNode identifier:#w))
			whenFalse:(PjReturnNode expression:PjNilNode new)}.
	self assertContentsOf: block convertsTo: expectedAst.
	block := [ [ 3 timesRepeat: [ |w| w ] ] ].
	expectedAst := PjBlockNode parameters:{} locals:#(w '$1') body:{
		PjForLoopNode
			from:(PjAssignNode target:(PjTempVariableNode identifier:'$1') expression:(PjLiteralValueNode value:1))
			to:(PjLiteralValueNode value:3)
			by:nil
			body:{PjAssignNode target:(PjTempVariableNode identifier:#w) expression:PjNilNode new.PjTempVariableNode identifier:#w}}.
	self assertContentsOf: block convertsTo: expectedAst.

]

{ #category : #testing }
PjConversionOptimizationTest >> testMethodReturns1 [
	| expectedBody expectedAst |
	messageConverter
		addAllConversions: {PjIfTrueOptimization. PjIfTrueIfFalseOptimization}.
	expectedBody := {three.
	two.
	(PjIfTrueIfFalseNode test: one whenTrue: returnTwo whenFalse: one).
	returnSelf}.
	expectedAst := PjMethodNode
		methodName: #return1
		body: expectedBody.
	self assertMethod: #return1 convertsTo: expectedAst
]

{ #category : #testing }
PjConversionOptimizationTest >> testMethodReturns2And3 [
	| expectedBody expectedAst |
	messageConverter
		addAllConversions: {PjIfTrueOptimization. PjIfTrueIfFalseOptimization}.
	expectedBody := {three.
	two.
	(PjIfTrueIfFalseNode
		test: one
		whenTrue: returnTwo
		whenFalse: returnOne)}.
	#(#return2 #return3)
		do: [ :selector | 
			expectedAst := PjMethodNode
				methodName: selector
				body: expectedBody.
			self assertMethod: selector convertsTo: expectedAst ]
]

{ #category : #testing }
PjConversionOptimizationTest >> testMethodReturns4 [
	| expectedBody expectedAst |
	messageConverter
		addAllConversions: {PjIfTrueOptimization. PjIfTrueIfFalseOptimization}.
	expectedBody := {three.
	two.
	(PjIfTrueIfFalseNode
		test: (PjIfTrueIfFalseNode test: two whenTrue: throwSelf whenFalse: three)
		whenTrue: returnTwo
		whenFalse: returnOne)}.
	expectedAst := PjMethodNode
		methodName: #return4
		body: {PjTryNode body: expectedBody}.
	self assertMethod: #return4 convertsTo: expectedAst
]

{ #category : #testing }
PjConversionOptimizationTest >> testOr [
	| expectedAst y returnAst |
	y := PjTempVariableNode identifier: #y.
	messageConverter addAllConversions: {PjOrOptimization}. 
	expectedAst := PjIfTrueIfFalseNode 
		test: y
		whenTrue: trueNode
		whenFalse: one.
	returnAst := PjIfTrueIfFalseNode 
		test: y
		whenTrue: returnTrue
		whenFalse: returnOne.
	self assertContentsOf: [ ^ y or: [1]] convertsTo: returnAst.
	self assertContentsOf: [ ^ y or: 1] convertsTo: returnAst.
	self assertContentsOf: [ y or: [1]] convertsTo: expectedAst.
	self assertContentsOf: [ y or: 1] convertsTo: expectedAst.
	
]

{ #category : #testing }
PjConversionOptimizationTest >> testStringConcatenation [
	messageConverter
		addAllConversions: {PjStringAppendOptimization}.
	self assertContentsOf: [ 'hello',1 ] convertsTo: (PjBinaryNode operator: #+ left: helloString right: one).
	self assertContentsOf: [ 1,'hello' ] convertsTo: (PjApplyNode receiver: one selector: #, args: {helloString}).
	self assertContentsOf: [ 'hello',1,2 ] convertsTo: (PjBinaryNode operator: #+ left: (PjBinaryNode operator: #+ left: helloString right: one) right: two).

]

{ #category : #testing }
PjConversionOptimizationTest >> testTimesRepeat [
	| in a temp1 temp2 |
	a := PjTempVariableNode identifier: #a.
	in := PjTempVariableNode identifier: #in.
	temp1 := PjTempVariableNode identifier: '$1'.
	temp2 := PjTempVariableNode identifier: '$2'.
	messageConverter addAllConversions: {
		PjTimesRepeatOptimization
	}.
	self
		assertContentsOf: [ 3 timesRepeat: [ a := 1]]
		convertsTo: (PjForLoopNode
			from: (PjAssignNode target: temp1 expression: one)
			to: three
			by: nil
			body:  {
				PjAssignNode
					target: a
					expression: one
			}).
	self
		assertContentsOf: [ in timesRepeat: [ a := 1]]
		convertsTo: (PjForLoopNode
			from: (PjAssignNode target: temp1 expression: one)
			to: (PjAssignNode target: temp2 expression: in)
			by: nil
			body:  {
				PjAssignNode
					target: a
					expression: one
			}).

]

{ #category : #testing }
PjConversionOptimizationTest >> testToDo [
	<expectedFailure> " temporarily disabled optimization "
	| in a xNode temp1 temp2 |
	a := PjTempVariableNode identifier: #a.
	in := PjTempVariableNode identifier: #in.
	temp1 := PjTempVariableNode identifier: '$1'.
	temp2 := PjTempVariableNode identifier: '$2'.
	messageConverter addAllConversions: {
		PjToDoOptimization. PjToByDoOptimization
	}. 
	self
		assertUnoptimizedContentsOf: [ 1 to: 10 do: [ in := 3. ^ a]].
	xNode := PjArgumentNode identifier: #x.
	self
		assertContentsOf: [ 1 to: 3 do: [:x| in := x. ^ a]]
		convertsTo: (PjForLoopNode
			from: (PjAssignNode target: xNode expression: one)
			to: three
			by: nil
			body:  {
				PjAssignNode
					target: in
					expression: xNode.
				PjReturnNode expression: a
			}).
	self
		assertContentsOf: [ 3 to: 1 by: -1 do: [:x| in := x. ^ a]]
		convertsTo: (PjForLoopNode
			from: (PjAssignNode target: xNode expression: three)
			to: one
			by: minusOne
			body:  {
				PjAssignNode
					target: in
					expression: xNode.
				PjReturnNode expression: a
			}).
	self
		assertContentsOf: [ 1 to: a by: in do: [:x| in := x. ^ a]]
		convertsTo: (PjForLoopNode
			from: (PjAssignNode target: xNode expression: one)
			to: (PjAssignNode target: temp1 expression: a)
			by: (PjAssignNode target: temp2 expression: in)
			body:  {
				PjAssignNode
					target: in
					expression: xNode.
				PjReturnNode expression: a
			}).
	self
		assertContentsOf: [ 1 to: a by: -2 do: [:x| in := x. ^ a]]
		convertsTo: (PjForLoopNode
			from: (PjAssignNode target: xNode expression: one)
			to: (PjAssignNode target: temp1 expression: a)
			by: minusTwo
			body:  {
				PjAssignNode
					target: in
					expression: xNode.
				PjReturnNode expression: a
			}).

]

{ #category : #testing }
PjConversionOptimizationTest >> testWhile [
	| for in a |
	for := PjTempVariableNode identifier: #for.
	a := PjTempVariableNode identifier: #a.
	in := PjTempVariableNode identifier: #in.
	messageConverter addAllConversions: {
		PjWhileTrueOptimization. PjWhileTrueDoOptimization.
		PjWhileFalseOptimization. PjWhileFalseDoOptimization.
	}. 
	self
		assertContentsOf: [ [self] whileTrue: [ in := for. ^ a]]
		convertsTo: (PjWhileNode test: selfNode body:  {
				PjAssignNode
					target: in
					expression: for.
				PjReturnNode expression: a
			}).
	self
		assertContentsOf: [ [self. in] whileTrue ]
		convertsTo: (PjWhileNode test: (PjSequenceNode expressions: {selfNode. in}) body:  {}).
	self
		assertContentsOf: [ [self] whileFalse: [ in := for. ^ a]]
		convertsTo:  (PjWhileNode test: selfNode not body:  {
				PjAssignNode
					target: in
					expression: for.
				PjReturnNode expression: a
			}).
	self
		assertContentsOf: [ [self. in] whileFalse ]
		convertsTo: (PjWhileNode test: (PjSequenceNode expressions: {selfNode. in}) not body:  {}).
	self
		assertContentsOf: [ self foo: [[self. in] whileFalse] ]
		convertsTo: (PjApplyNode receiver: selfNode selector: #foo: args: (PjBlockNode parameters: #() locals: #() body: {PjWhileNode test: (PjSequenceNode expressions: {selfNodeInBlock. in}) not body:  {}}) asOrderedCollection).

]

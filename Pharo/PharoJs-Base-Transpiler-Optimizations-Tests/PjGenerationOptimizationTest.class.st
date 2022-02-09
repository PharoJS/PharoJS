Class {
	#name : #PjGenerationOptimizationTest,
	#superclass : #PjStringGenerationTest,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Tests-Tests'
}

{ #category : #testing }
PjGenerationOptimizationTest >> testAnd [
	| y inputAst |
	y := PjTempVariableNode identifier: #y.
	inputAst := PjApplyNode
		receiver: selfNode
		selector: #foo:
		args: {PjIfTrueIfFalseNode 
			test: y
			whenTrue: one
			whenFalse: falseNode}.
	self assert:  inputAst asStringEquals: 'this._foo_(true==y&&1)'.
]

{ #category : #testing }
PjGenerationOptimizationTest >> testIfFalse [
	| y inputAst returnAst |
	y := PjTempVariableNode identifier: #y.
	inputAst := PjIfTrueNode 
		test: y not
		whenTrue: one.
	returnAst := PjReturnNode expression: (PjIfTrueIfFalseNode 
		test: y
		whenTrue: nilNode
		whenFalse: one).
	self assert:  inputAst asStringEquals: 'if(false==y){1}'.
	self assert:  returnAst asStringEquals: 'return true==y?undefined:1'
]

{ #category : #testing }
PjGenerationOptimizationTest >> testIfNil [
	| inputAst tempVariable tempVariableName y |
	y := PjTempVariableNode identifier: #y.
	tempVariableName := PjStringGenerator tempNamePrefix, '1'.
	tempVariable := PjTempVariableNode identifier: tempVariableName asSymbol.
	inputAst := PjReturnNode expression: (
		PjIfNilNode 
			test: (self apply: y selector: #foo)
			whenNil: one).
	self assert: inputAst asStringEquals: 'return $asNil$(y)._foo()==undefined?1:undefined'.

	inputAst := PjIfNilNode 
			test: (self apply: y selector: #foo)
			whenNil: one.
	self assert: inputAst asStringEquals: 'if($asNil$(y)._foo()==undefined){1}'.
]

{ #category : #testing }
PjGenerationOptimizationTest >> testIfNilCaseForIfNilIfNotNil [
	| expectedAst tempVariable tempVariableName y |
	y := PjTempVariableNode identifier: #y.
	tempVariableName := PjStringGenerator tempNamePrefix, '1'.
	tempVariable := PjTempVariableNode identifier: tempVariableName asSymbol.
	expectedAst := PjReturnNode expression: (
		PjIfNilIfNotNilNode 
			test: (PjAssignNode
				target: tempVariable
				expression: (self apply: y selector: #foo))
			whenNotNil: tempVariable
			whenNil: one).
	self
		assert: expectedAst
		asStringEquals: 'return ($1=$asNil$(y)._foo())==undefined?1:$1'
]

{ #category : #testing }
PjGenerationOptimizationTest >> testIfNotNil [
	| expectedAst tempVariable tempVariableName y |
	y := PjTempVariableNode identifier: #y.
	tempVariableName := #x.
	tempVariable := PjTempVariableNode identifier: tempVariableName.

	expectedAst := PjReturnNode expression: (
		PjIfNotNilNode 
			test: (PjAssignNode
				target: tempVariable
				expression: (self apply: y selector: #foo nonNil: false))
			whenNotNil: tempVariable).
	self
		assert: expectedAst
		asStringEquals: 'return (x=$asNil$(y)._foo())==undefined?undefined:x'.

	expectedAst := PjReturnNode expression: (
		PjIfNotNilNode 
			test: (PjAssignNode
				target: tempVariable
				expression: (self apply: y selector: #foo nonNil: false))
			whenNotNil: (self apply: tempVariable selector: #foo nonNil: true)).
	self
		assert: expectedAst
		asStringEquals: 'return (x=$asNil$(y)._foo())==undefined?undefined:x._foo()'.

	expectedAst := PjIfNotNilNode 
			test: (PjAssignNode
				target: tempVariable
				expression: (self apply: y selector: #foo nonNil: false))
			whenNotNil: tempVariable.
	self assert: expectedAst asStringEquals: 'if((x=$asNil$(y)._foo())!=undefined){x}'.

	expectedAst := PjIfNotNilNode 
			test: (PjAssignNode
				target: tempVariable
				expression: (self apply: y selector: #foo))
			whenNotNil: (self apply: tempVariable selector: #foo nonNil: true).
	self
		assert: expectedAst
		asStringEquals: 'if((x=$asNil$(y)._foo())!=undefined){x._foo()}'.

	expectedAst := PjIfNotNilNode
		test: y
		whenNotNil: returnOne. 
	self
		assert: expectedAst
		asStringEquals: 'if(y!=undefined){return 1}'.
]

{ #category : #testing }
PjGenerationOptimizationTest >> testIfNotNilCaseForIfNilIfNotNil [
	| expectedAst tempVariable tempVariableName y |
	y := PjTempVariableNode identifier: #y.
	tempVariableName := #x.
	tempVariable := PjTempVariableNode identifier: tempVariableName.

	expectedAst := PjReturnNode expression: (
		PjIfNilIfNotNilNode 
			test: (PjAssignNode
				target: tempVariable
				expression: (self apply: y selector: #foo)) 
			whenNotNil: tempVariable
			whenNil: one).
	self assert: expectedAst asStringEquals: 'return (x=$asNil$(y)._foo())==undefined?1:x'.

	expectedAst := PjReturnNode expression: (
		PjIfNilIfNotNilNode 
			test: (PjAssignNode
				target: tempVariable
				expression: (self apply: y selector: #foo))
			whenNotNil: (self apply: tempVariable selector: #foo nonNil: true)
			whenNil: one).
	self assert: expectedAst asStringEquals: 'return (x=$asNil$(y)._foo())==undefined?1:x._foo()'.

	expectedAst := PjIfNilIfNotNilNode 
			test: (PjAssignNode
				target: tempVariable
				expression: (self apply: y selector: #foo))
			whenNotNil: tempVariable
			whenNil: one .
	self assert: expectedAst asStringEquals: 'if((x=$asNil$(y)._foo())==undefined){1;}else{x}'.

	expectedAst := PjIfNilIfNotNilNode 
			test: (PjAssignNode
				target: tempVariable
				expression: (self apply: y selector: #foo))
			whenNotNil: (self apply: tempVariable selector: #foo nonNil: true)
			whenNil: one.
	self assert: expectedAst asStringEquals: 'if((x=$asNil$(y)._foo())==undefined){1;}else{x._foo()}'
]

{ #category : #testing }
PjGenerationOptimizationTest >> testIfTrue [
	| y inputAst |
	y := PjTempVariableNode identifier: #y.
	inputAst := PjIfTrueNode 
		test: y
		whenTrue: one.
	self assert:  inputAst asStringEquals: 'if(true==y){1}'.
]

{ #category : #testing }
PjGenerationOptimizationTest >> testIfTrueIfFalse [
	| y inputAst returnAst |
	y := PjTempVariableNode identifier: #y.
	inputAst := PjIfTrueIfFalseNode 
		test: y
		whenTrue: one
		whenFalse: two.
	returnAst := PjReturnNode expression: inputAst.
	self assert:  inputAst asStringEquals: 'if(true==y){1}else{2}'.
	self assert:  returnAst asStringEquals: 'return true==y?1:2'
]

{ #category : #testing }
PjGenerationOptimizationTest >> testOr [
	| y inputAst |
	y := PjTempVariableNode identifier: #y.
	inputAst := PjApplyNode
		receiver: selfNode
		selector: #foo:
		args: {PjIfTrueIfFalseNode 
			test: y
			whenTrue: trueNode
			whenFalse: one}.
	self assert:  inputAst asStringEquals: 'this._foo_(true==y||1)'.
]

{ #category : #testing }
PjGenerationOptimizationTest >> testSequence [
	| x inputAst |
	x := PjTempVariableNode identifier: #x.
	inputAst := PjSequenceNode
		expressions:
			{one.
			two.
			(PjIfTrueIfFalseNode
				test: (self apply: x selector: #foo)
				whenTrue: one
				whenFalse: two)}.
	self
		assert: (PjIfTrueNode test: inputAst whenTrue: one)
		asStringEquals:
			'if(true==(1,2,(true==$asNil$(x)._foo()?1:2))){1}'.
	self
		assert: inputAst
		asStringEquals: '1;2;if(true==$asNil$(x)._foo()){1}else{2}'.
	inputAst := self
		simpleBlock:
			{(PjIfTrueIfFalseNode
				test: one
				whenTrue:
					(PjSequenceNode
						expressions:
							{two.
							(PjIfTrueNode test: one not whenTrue: two).
							returnThree})
				whenFalse:
					(PjReturnNode
						expression:
							(self
								simpleBlock:
									{two.
									returnThree}
								locals: #()))).
			two.
			returnThree}
		locals: #().
	self
		assert: inputAst
		asStringEquals:
			'(function(){if(true==1){2;if(false==1){2};return 3}else{return function(){2;return 3}};2;return 3})'.
	inputAst := PjBlockNode
		parameters: #(a)
		locals: #(d)
		body:
			{(PjIfTrueNode
				test: falseNode
				whenTrue:
					(PjSequenceNode
						expressions:
							{(PjAssignNode
								target: (PjTempVariableNode identifier: #d)
								expression: trueNode)})).
			(PjAssignNode
				target: (PjTempVariableNode identifier: #d)
				expression: falseNode).
			(PjReturnNode expression: (PjArgumentNode identifier: #a))}.
	self
		assert: inputAst
		asStringEquals: '(function(a){var d;if(true==false){d=true};d=false;return a})'.
	inputAst := PjBlockNode
		parameters: #(a)
		locals: #(d)
		body:
			{(PjIfTrueNode
				test: falseNode
				whenTrue: (PjSequenceNode expressions: #())).
			(PjAssignNode
				target: (PjTempVariableNode identifier: #d)
				expression: falseNode).
			(PjReturnNode expression: (PjArgumentNode identifier: #a))}.
	self
		assert: inputAst
		asStringEquals: '(function(a){var d;if(true==false){};d=false;return a})'
]

{ #category : #testing }
PjGenerationOptimizationTest >> testToDo [
	| in a xNode temp1 temp2 |
	a := PjTempVariableNode identifier: #a.
	in := PjTempVariableNode identifier: #in.
	temp1 := PjTempVariableNode identifier: '$1'.
	temp2 := PjTempVariableNode identifier: '$2'.
	xNode := PjArgumentNode identifier: #x.
	self
		assert: (PjForLoopNode
			from: (PjAssignNode target: xNode expression: one)
			to: three
			by: nil
			body:  {
				PjAssignNode
					target: in
					expression: xNode.
				PjReturnNode expression: a
			})
		asStringEquals: 'for(var x=1;x<=3;++x){$in=x;return a}'.
	self
		assert: (PjForLoopNode
			from: (PjAssignNode target: xNode expression: three)
			to: one
			by: minusOne
			body:  {
				PjAssignNode
					target: in
					expression: xNode.
				PjReturnNode expression: a
			})
		asStringEquals: 'for(var x=3;x>=1;--x){$in=x;return a}'.
	self
		assert: (PjForLoopNode
			from: (PjAssignNode target: xNode expression: one)
			to: (PjAssignNode target: temp1 expression: a)
			by: (PjAssignNode target: temp2 expression: in)
			body:  {
				PjAssignNode
					target: in
					expression: xNode.
				PjReturnNode expression: a
			})
		asStringEquals: 'for(var x=1,$1=a,$2=$in;$2>=0?x<=$1:x>=$1;x+=$2){$in=x;return a}'.
	self
		assert: (PjForLoopNode
			from: (PjAssignNode target: xNode expression: one)
			to: (PjAssignNode target: temp1 expression: a)
			by: minusTwo
			body:  {
				PjAssignNode
					target: in
					expression: xNode.
				PjReturnNode expression: a
			})
		asStringEquals: 'for(var x=1,$1=a;x>=$1;x+=-2){$in=x;return a}'.
]

{ #category : #testing }
PjGenerationOptimizationTest >> testWhile [
	| for a in |
	for := PjTempVariableNode identifier: #for.
	a := PjTempVariableNode identifier: #a.
	in := PjTempVariableNode identifier: #in.
	self
		assert: (PjWhileNode test: selfNode body:  {
				PjAssignNode
					target: in
					expression: for.
				PjReturnNode expression: a
			})
		asStringEquals: 'while(true==this){$in=$for;return a}'.
	self
		assert: (PjWhileNode test: (PjSequenceNode expressions: {selfNode. in}) body:  {})
		asStringEquals: 'while(true==(this,$in)){}'.
	self
		assert: (PjWhileNode test: selfNode not body:  {
				PjAssignNode
					target: in
					expression: for.
				PjReturnNode expression: a
			})
		asStringEquals: 'while(false==this){$in=$for;return a}'.
	self
		assert: (PjWhileNode test: (PjSequenceNode expressions: {selfNode. in}) not body:  {})
		asStringEquals: 'while(false==(this,$in)){}'.
]

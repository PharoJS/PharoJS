Class {
	#name : #PjStringGenerationTest,
	#superclass : #PjAstTests,
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #accessing }
PjStringGenerationTest class >> classVariablesHolderName [
	^ PjStringGenerator classVariablesHolderName
]

{ #category : #asserting }
PjStringGenerationTest >> assert: aPjJavascriptAstNode asStringEquals: aString [
	self assert: aPjJavascriptAstNode asJavascriptString equals: aString

]

{ #category : #accessing }
PjStringGenerationTest >> classVariablesHolderName [
	^ self class classVariablesHolderName
]

{ #category : #accessing }
PjStringGenerationTest >> nilTestFunctionName [
	^PjStringGenerator nilTestFunctionName
]

{ #category : #testing }
PjStringGenerationTest >> testArray [
	| x |
	x := PjTempVariableNode identifier: #x.
	self
		assert: (PjArrayNode expressions: { one. two. self apply: x selector: #foo })
		asStringEquals: '[1,2,$asNil$(x)._foo()]'.

]

{ #category : #testing }
PjStringGenerationTest >> testBlock [
	self
		assert: (PjBlockNode parameters: #(a for) locals: #(d in) body: {
				PjAssignNode
					target: (PjTempVariableNode identifier: #in)
					expression: (PjArgumentNode identifier: #for).
				PjReturnNode expression: (PjArgumentNode identifier: #a)
			})
		asStringEquals: '(function(a,$for){var d,$in;$in=$for;return a})'.

]

{ #category : #testing }
PjStringGenerationTest >> testClassCall [
	self
		assert: (self apply: (PjClassNode identifier: #Number) selector: #one)
		asStringEquals: 'Number._one()'
]

{ #category : #testing }
PjStringGenerationTest >> testClassVariables [
	| astAssignment classVar |
	classVar := (PjClassVariableNode identifier: #ClassVarForTest).
	astAssignment := PjAssignNode 
		target:  (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true)
		expression: (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true).
	self
		assert: astAssignment
		asStringEquals: 'this.ClassVarForTest_(this.ClassVarForTest)'.

	astAssignment := PjAssignNode 
		target:  (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true)
		expression: (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true).
	self
		assert: (PjStringGenerator new currentClass: self class; asString: astAssignment)
		equals: 'this.ClassVarForTest_(this.ClassVarForTest)'.

	astAssignment := PjAssignNode 
		target:  (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true)
		expression: (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true).
	self
		assert: (PjStringGenerator new currentClass: self class class; asString: astAssignment)
		equals: 'this.',self classVariablesHolderName,'.ClassVarForTest_(this.',self classVariablesHolderName,'.ClassVarForTest)'.

	classVar myClass: self class class.
	astAssignment := PjAssignNode 
		target:  (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true)
		expression: (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true).
	self
		assert: (PjStringGenerator new currentClass: self class class; asString: astAssignment)
		equals: 'this.',self classVariablesHolderName,'.ClassVarForTest=this.',self classVariablesHolderName,'.ClassVarForTest'.

]

{ #category : #testing }
PjStringGenerationTest >> testField [
	| x bar |
	x := PjTempVariableNode identifier: #x.
	bar := PjMessageSelectorNode identifier: #bar.
	self
		assert: (PjFieldNode target: selfNode selectorNode: foo isNonNil: true)
		asStringEquals: 'this.foo'.
	self
		assert: (PjApplyNode func: (PjFieldNode target:  (PjFieldNode target: selfNode selectorNode: foo isNonNil: true)  selectorNode: bar isNonNil: false) args: #())
		asStringEquals: self nilTestFunctionName,'(this.foo)._bar()'.
	self
		assert: (PjFieldNode target: x selectorNode: foo isNonNil: false)
		asStringEquals: self nilTestFunctionName,'(x).foo'.
	self
		assert: (PjFieldNode target: pi selectorNode: foo isNonNil: true)
		asStringEquals: '3.1415926.foo'.
	self
		assert: (PjFieldNode target: three selectorNode: foo isNonNil: true)
		asStringEquals: '(3).foo'.
	self
		assert: (PjFieldNode target: foo selectorNode: bar isNonNil: true)
		asStringEquals: '"foo"._bar'.
	self
		assert: (PjFieldNode target: (PjVariableNode identifier: #x) selectorNode: foo isNonNil: false)
		asStringEquals: self nilTestFunctionName,'(x).foo'
]

{ #category : #testing }
PjStringGenerationTest >> testFieldForCall [
	| x |
	x := PjTempVariableNode identifier: #x.
	self
		assert: (self apply: selfNode selector: #foo) 
		asStringEquals: 'this._foo()'.
	self
		assert: (self apply: three selector: #foo) 
		asStringEquals: '(3)._foo()'.
	self
		assert: (self apply: pi selector: #foo) 
		asStringEquals: '3.1415926._foo()'.
	self
		assert: (self apply: selfNode selector: PjStringGenerator jsNativePrefix,#foo:)
		asStringEquals: 'this.foo()'.
	self
		assert: (self apply: selfNode selector: #bar:)
		asStringEquals: 'this._bar_()'.
	self
		assert: (self apply: selfNode selector: #<=)
		asStringEquals: 'this._60_61_()'.
	self
		assert: (PjApplyNode func: (PjFieldNode target: selfNode selectorNode: nil isNonNil: true) args: nil)
		asStringEquals: 'this'.
	self
		assert: (PjApplyNode func: (PjFieldNode target: x selectorNode: nil isNonNil: false) args: nil)
		asStringEquals: self nilTestFunctionName,'(x)'.
	self
		assert: (PjApplyNode func: (PjFieldNode target: (PjFieldNode target: selfNode selectorNode: iv1ForTest isNonNil: true) selectorNode: nil isNonNil: false) args: nil)
		asStringEquals: self nilTestFunctionName,'(this.iv1ForTest)'
]

{ #category : #testing }
PjStringGenerationTest >> testGlobalCall [
	self
		assert: (self apply: (PjGlobalNode identifier: #Number) selector: #one)
		asStringEquals: self nilTestFunctionName,'(Number)._one()'
]

{ #category : #testing }
PjStringGenerationTest >> testLiteral [
	self assert: (PjLiteralValueNode value: 42) asStringEquals: '42'.
	self assert: (PjLiteralValueNode value: '42') asStringEquals: '"42"'.
	self assert: (PjLiteralValueNode value: $x) asStringEquals: '"x"'.
	self assert: (PjLiteralValueNode value: nil) asStringEquals: 'undefined'.
	self assert: (PjLiteralValueNode value: (String with: (Character value: 7)),'a\b"
x',(String with: Character null)) asStringEquals: '"\007a\\b\"\rx\000"'.
	self assert: (PjLiteralValueNode value: 'a\b"',(String with: (Character value:257)) ) asStringEquals: '"a\\b\"Ä"'.
	self assert: (PjLiteralValueNode value: (String with: Character null),'a\b"
xようこそy',(String with: (Character value:257)) ) asStringEquals: '"\000a\\b\"\rxããããyÄ"'
]

{ #category : #testing }
PjStringGenerationTest >> testMethod [
	self
		assert:
			(PjMethodNode
				parameters: #(#a #for)
				locals: #(#d #in)
				body:
					{(PjAssignNode
						target: (PjTempVariableNode identifier: #in)
						expression: (PjArgumentNode identifier: #for)).
					(PjReturnNode expression: (PjArgumentNode identifier: #a))}
				methodName: #foo
				needsSelf: false
				isClassMethod: false)
		asStringEquals: 'function _foo(a,$for){var d,$in;$in=$for;return a}'.
	self
		assert:
			(PjMethodNode
				parameters: #(#a)
				locals: #(#d)
				body:
					{(PjAssignNode
						target: (PjTempVariableNode identifier: #d)
						expression:
							(PjArrayNode
								expressions:
									{PjBlockNode
										parameters: #()
										locals: #()
										body:
											{one.
											two}})).
					(PjReturnNode expression: (PjArgumentNode identifier: #a))}
				methodName: #foo
				needsSelf: false
				isClassMethod: false)
		asStringEquals: 'function _foo(a){var d;d=[function(){1;2}];return a}'
]

{ #category : #testing }
PjStringGenerationTest >> testObject [
	self
		assert: (PjObjectNode dictionary: { #a -> selfNode. #* -> nilNode } asDictionary)
		asStringEquals: '{"*":undefined,a:this}'.

]

{ #category : #testing }
PjStringGenerationTest >> testOperatorPrecedence [
	self assert: (PjBinaryNode operator: #+ left: (PjBinaryNode operator: #+ left: two right: three) right: one) asStringEquals: '2+3+1'.
	self assert: (PjBinaryNode operator: #+ left: (PjBinaryNode operator: #- left: two right: three) right: one) asStringEquals: '2-3+1'.
	self assert: (PjBinaryNode operator: #- left: (PjBinaryNode operator: #+ left: two right: three) right: one) asStringEquals: '2+3-1'.
	self assert: (PjBinaryNode operator: #- left: ((PjAssignNode target: (PjTempVariableNode identifier: #x) expression:  two)) right: one) asStringEquals: '(x=2)-1'.
	self assert: (PjBinaryNode operator: #* left: (PjBinaryNode operator: #* left: two right: three) right: one) asStringEquals: '2*3*1'.
	self assert: (PjBinaryNode operator: #+ left: (PjBinaryNode operator: #* left: two right: three) right: one) asStringEquals: '2*3+1'.
	self assert: (PjBinaryNode operator: #+ left: two right: (PjBinaryNode operator: #* left: three right: one)) asStringEquals: '2+3*1'.
	self assert: (PjBinaryNode operator: #* left: (PjBinaryNode operator: #+ left: two right: three) right: one) asStringEquals: '(2+3)*1'.
	self assert: (PjBinaryNode operator: #* left: two right: (PjBinaryNode operator: #/ left:  (PjBinaryNode operator: #+ left: three right: one) right: (PjBinaryNode operator: #- left: (PjLiteralValueNode value: 5) right: (PjLiteralValueNode value: 6)))) asStringEquals: '2*(3+1)/(5-6)'..
	self assert: (PjBinaryNode operator: #+ left: two right: (PjBinaryNode operator: #- left:  (PjBinaryNode operator: #* left: three right: one) right: (PjBinaryNode operator: #/ left: (PjLiteralValueNode value: 5) right: (PjLiteralValueNode value: 6)))) asStringEquals: '2+3*1-5/6'
]

{ #category : #testing }
PjStringGenerationTest >> testOptimizedJsX [
	self
		assert: (PjGlobalNode identifier: #this)
		asStringEquals: 'this'.
	self
		assert: ((PjAssignNode target: (PjFieldNode target: selfNode selectorNode: three isNonNil: true) expression: two))
		asStringEquals: 'this[3]=2'.
	self
		assert: ((PjAssignNode target: (PjFieldNode target: selfNode selectorNode: foo isNonNil: true) expression: two))
		asStringEquals: 'this.foo=2'.
	self
		assert: ((PjAssignNode target: (PjFieldNode target: selfNode selectorNode: (PjLiteralValueNode value: 'a$b_c') isNonNil: true) expression: two))
		asStringEquals: 'this.a$b_c=2'.
	self
		assert: ((PjAssignNode target: (PjFieldNode target: selfNode selectorNode: (PjLiteralValueNode value: 'a.b') isNonNil: true) expression: two))
		asStringEquals: 'this["a.b"]=2'
]

{ #category : #testing }
PjStringGenerationTest >> testPoolVariables [
	| astAssignment classVar |
	classVar := PjPoolVariableNode identifier: #PoolVarForTest.
	astAssignment := PjAssignNode 
		target:  (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true)
		expression: (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true).
	self
		assert: astAssignment
		asStringEquals: 'this.PoolVarForTest_(this.PoolVarForTest$())'.
	astAssignment := PjAssignNode 
		target:  (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true)
		expression: (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true).
	self
		assert: (PjStringGenerator new currentClass: self class; asString: astAssignment)
		equals: 'this.PoolVarForTest_(this.PoolVarForTest$())'.
	astAssignment := PjAssignNode 
		target:  (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true)
		expression: (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true).
	self
		assert: (PjStringGenerator new currentClass: self class class; asString: astAssignment)
		equals: 'this.',self classVariablesHolderName,'.PoolVarForTest_(this.',self classVariablesHolderName,'.PoolVarForTest$())'.
	classVar myClass: self class class.
	astAssignment := PjAssignNode 
		target:  (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true)
		expression: (PjFieldNode target: selfNode selectorNode: classVar isNonNil: true).
	self
		assert: (PjStringGenerator new currentClass: self class class; asString: astAssignment)
		equals: 'this.',self classVariablesHolderName,'.PoolVarForTest_(this.',self classVariablesHolderName,'.PoolVarForTest$())'.

]

{ #category : #testing }
PjStringGenerationTest >> testReservedWords [
	self
		assert: (PjFieldNode target: selfNode selectorNode: (PjInstanceVariableNode identifier: #in ) isNonNil: true)
		asStringEquals: 'this.in'.
	self
		assert: (PjTempVariableNode identifier: #prototype )
		asStringEquals: 'prototype'.
	self
		assert: (PjTempVariableNode identifier: #for )
		asStringEquals: '$for'.
	self
		assert: (PjArgumentNode identifier: #prototype )
		asStringEquals: 'prototype'.
	self
		assert: (PjArgumentNode identifier: #for )
		asStringEquals: '$for'.
	self
		assert: (PjGlobalNode identifier: #prototype )
		asStringEquals: 'prototype'.
	self
		assert: (PjGlobalNode identifier: #for )
		asStringEquals: 'for'.
	self
		assert: (PjClassNode identifier: #prototype )
		asStringEquals: 'prototype'.
	self
		assert: (PjClassNode identifier: #for )
		asStringEquals: 'for'.
	self
		assert: (PjClassVariableNode identifier: #prototype )
		asStringEquals: '.$prototype'.
	self
		assert: (PjClassVariableNode identifier: #for )
		asStringEquals: '.for'.
	self
		assert: (PjInstanceVariableNode identifier: #while )
		asStringEquals: '.while'.
	self
		assert: (PjInstanceVariableNode identifier: #constructor )
		asStringEquals: '.$constructor'.
	self
		assert: (PjInstanceVariableNode identifier: #prototype )
		asStringEquals: '.$prototype'.

]

{ #category : #testing }
PjStringGenerationTest >> testReturn [
	self assert: returnThree  asStringEquals: 'return 3'
]

{ #category : #testing }
PjStringGenerationTest >> testSelf [
	self assert: selfNode asStringEquals: 'this'.
	self
		assert: (self apply: (PjSelfNode myClass: Integer) selector: #value)
		asStringEquals: 'this._value()'.
	self
		assert: (self apply: (PjSelfNode inBlock: true) selector: #value)
		asStringEquals: PjStringGenerator selfName,'._value()'
]

{ #category : #testing }
PjStringGenerationTest >> testSuperCall [
	self
		assert: (self apply: (PjSuperNode myClass: Integer) selector: #value)
		asStringEquals: 'Number.prototype._value.call(this)'.
	self
		assert: (self apply: ((PjSuperNode myClass: Integer class) inBlock: true) selector: #value)
		asStringEquals: 'Number._value.call(',PjStringGenerator selfName,')'
]

{ #category : #testing }
PjStringGenerationTest >> testTry [
	self
		assert: (PjTryNode body: throwThree)
		asStringEquals: 'var ', PjStringGenerator nonLocalReturnVariableName, '={};try{throw $_err_$=3}catch(e){if(e===', PjStringGenerator nonLocalReturnVariableName, ')return e;throw e}'
]

{ #category : #testing }
PjStringGenerationTest >> testUnparsedString [
	self
		assert: (PjUnparsedStringNode string: 'a.b^c')
		asStringEquals: 'a.b^c'.

]

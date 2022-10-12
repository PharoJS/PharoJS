Class {
	#name : #PjStringGenerationTest,
	#superclass : #PjAbstractAstTest,
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #accessing }
PjStringGenerationTest class >> classVariablesHolderName [

	^ PjStringGenerator classVariablesHolderName
]

{ #category : #asserting }
PjStringGenerationTest >> assert: aPjJavascriptAstNode asStringEquals: aString [
	self
		assert: (self generator asString: aPjJavascriptAstNode)
		equals: aString
]

{ #category : #accessing }
PjStringGenerationTest >> classVariablesHolderName [
	^ self class classVariablesHolderName
]

{ #category : #asserting }
PjStringGenerationTest >> generator [
	^ PjStringGenerator new transpiler: self
]

{ #category : #accessing }
PjStringGenerationTest >> nilTestFunctionName [
	^PjStringGenerator nilTestFunctionName
]

{ #category : #'test mock' }
PjStringGenerationTest >> poolReference: anUndefinedObject for: anUndefinedObject2 [ 
	^ 'cp$'
]

{ #category : #accessing }
PjStringGenerationTest >> selectorsPrefix [
	^ '_'
]

{ #category : #tests }
PjStringGenerationTest >> testArray [
	| x |
	x := PjTempVariableNode identifier: #x.
	self
		assert: (PjArrayNode expressions: { one. two. self apply: x selector: #foo })
		asStringEquals: '[1,2,$asNil$(x)._foo()]'.
]

{ #category : #tests }
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

{ #category : #tests }
PjStringGenerationTest >> testClassCall [
	self
		assert: (self apply: (PjClassNode identifier: #Number) selector: #one)
		asStringEquals: 'Number._one()'
]

{ #category : #tests }
PjStringGenerationTest >> testClassVariables [
	| astAssignment classVar |
	classVar := PjClassVariableNode identifier: #ClassVarForTest.
	astAssignment := PjAssignNode target: classVar expression: classVar.
	self
		assert: astAssignment
		asStringEquals: 'cp$.ClassVarForTest=cp$.ClassVarForTest'.
	self
		assert:
			(self generator
				currentClass: self class;
				asString: astAssignment)
		equals: 'cp$.ClassVarForTest=cp$.ClassVarForTest'.
	self
		assert:
			(self generator
				currentClass: self class class;
				asString: astAssignment)
		equals: 'cp$.ClassVarForTest=cp$.ClassVarForTest'.
	classVar myClass: self class class.
	self
		assert:
			(self generator
				currentClass: self class class;
				asString: astAssignment)
		equals: 'cp$.ClassVarForTest=cp$.ClassVarForTest'
]

{ #category : #tests }
PjStringGenerationTest >> testField [
	| x bar |
	x := PjTempVariableNode identifier: #x.
	bar := PjMessageSelectorNode identifier: #bar.
	self
		assert: (PjFieldNode target: selfNode selectorNode: foo isNonNil: true)
		asStringEquals: 'this.foo'.
	self
		assert: (PjApplyNode func: (PjFieldNode target: (PjFieldNode target: selfNode selectorNode: foo isNonNil: true)  selectorNode: bar isNonNil: false) args: #())
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

{ #category : #tests }
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

{ #category : #tests }
PjStringGenerationTest >> testGlobalCall [
	self
		assert: (self apply: (PjGlobalNode identifier: #Number) selector: #one)
		asStringEquals: self nilTestFunctionName,'(Number)._one()'
]

{ #category : #tests }
PjStringGenerationTest >> testLiteral [
	self assert: (PjLiteralValueNode value: 42) asStringEquals: '42'.
	self assert: (PjLiteralValueNode value: '42') asStringEquals: '"42"'.
	self assert: (PjLiteralValueNode value: $x) asStringEquals: '"x"'.
	self assert: (PjLiteralValueNode value: nil) asStringEquals: 'null'.
	self assert: (PjLiteralValueNode value: (String with: (Character value: 7)),'a\b"
x',(String with: Character null)) asStringEquals: '"\x07a\\b\"\rx\x00"'.
	self assert: (PjLiteralValueNode value: 'a\b"',(String with: (Character value:257)) ) asStringEquals: '"a\\b\"\u0101"'.
	self assert: (PjLiteralValueNode value: (String with: Character null),'a\b"
xようこそy',(String with: (Character value:257)) ) asStringEquals: '"\x00a\\b\"\rx\u3088\u3046\u3053\u305Dy\u0101"'.
]

{ #category : #tests }
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

{ #category : #tests }
PjStringGenerationTest >> testObject [
	self
		assert: (PjObjectNode dictionary: { #a -> selfNode. #* -> nilNode } asDictionary)
		asStringEquals: '{"*":null,a:this}'.
]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
PjStringGenerationTest >> testPoolVariables [
	| astAssignment poolVar |
	poolVar := (PjPoolVariableNode identifier: #PoolVarForTest)
		poolReference: PjBrowserGlobals.
	astAssignment := PjAssignNode target: poolVar expression: poolVar.
	self
		assert: astAssignment
		asStringEquals: 'cp$.PoolVarForTest=cp$.PoolVarForTest'.
	self
		assert:
			(self generator
				currentClass: self class;
				asString: astAssignment)
		equals: 'cp$.PoolVarForTest=cp$.PoolVarForTest'.
	self
		assert:
			(self generator
				currentClass: self class class;
				asString: astAssignment)
		equals: 'cp$.PoolVarForTest=cp$.PoolVarForTest'.
	poolVar myClass: self class class.
	self
		assert:
			(self generator
				currentClass: self class class;
				asString: astAssignment)
		equals: 'cp$.PoolVarForTest=cp$.PoolVarForTest'
]

{ #category : #tests }
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
		assert: ((PjClassVariableNode identifier: #prototype) myClass: self class)
		asStringEquals: 'cp$.$prototype'.
	self
		assert: (PjClassVariableNode identifier: #for )
		asStringEquals: 'cp$.for'.
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

{ #category : #tests }
PjStringGenerationTest >> testReturn [
	self assert: returnThree  asStringEquals: 'return 3'
]

{ #category : #tests }
PjStringGenerationTest >> testSelf [
	self assert: selfNode asStringEquals: 'this'.
	self
		assert: (self apply: (PjSelfNode myClass: Integer) selector: #value)
		asStringEquals: 'this._value()'.
	self
		assert: (self apply: (PjSelfNode inBlock: true) selector: #value)
		asStringEquals: PjStringGenerator selfName,'._value()'
]

{ #category : #tests }
PjStringGenerationTest >> testSuperCall [
	self
		assert: (self apply: (PjSuperNode myClass: Integer) selector: #value)
		asStringEquals: 'Number.prototype._value.call(this)'.
	self
		assert: (self apply: ((PjSuperNode myClass: Integer class) inBlock: true) selector: #value)
		asStringEquals: 'Number._value.call(',PjStringGenerator selfName,')'
]

{ #category : #tests }
PjStringGenerationTest >> testTry [
	self
		assert: (PjTryNode body: throwThree)
		asStringEquals: 'var ', PjStringGenerator nonLocalReturnVariableName, '={};try{throw $_err_$=3}catch(e){if(e===', PjStringGenerator nonLocalReturnVariableName, ')return e;throw e}'
]

{ #category : #tests }
PjStringGenerationTest >> testUnparsedString [
	self
		assert: (PjUnparsedStringNode string: 'a.b^c')
		asStringEquals: 'a.b^c'.
]

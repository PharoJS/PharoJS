"
I define a set of instance variables used in a variety of tests
"
Class {
	#name : #PjAstTests,
	#superclass : #TestCase,
	#instVars : [
		'iv1ForTest',
		'iv2ForTest',
		'one',
		'two',
		'three',
		'returnOne',
		'throwOne',
		'returnTwo',
		'throwTwo',
		'returnThree',
		'throwThree',
		'foo',
		'nilNode',
		'returnNil',
		'throwNil',
		'returnSelf',
		'selfNode',
		'throwSelf',
		'pi',
		'helloString',
		'selfNodeInBlock',
		'minusOne',
		'minusTwo',
		'trueNode',
		'falseNode',
		'returnTrue',
		'returnFalse'
	],
	#classVars : [
		'ClassVarForTest'
	],
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #testing }
PjAstTests >> apply: aPjJavascriptAstNode selector: aSelector [
	^ self apply: aPjJavascriptAstNode selector: aSelector nonNil: aPjJavascriptAstNode isNonNil

]

{ #category : #testing }
PjAstTests >> apply: aPjJavascriptAstNode selector: aSelector nonNil: nonNil [
	^ PjApplyNode func: (PjFieldNode target: aPjJavascriptAstNode selectorNode: (PjMessageSelectorNode identifier: aSelector asSymbol) isNonNil: nonNil)
		args: #()

]

{ #category : #accessing }
PjAstTests >> pharoJsSelectorPrefix [
	^ '_'
]

{ #category : #running }
PjAstTests >> setUp [
	super setUp.
	minusTwo := PjLiteralValueNode value: -2.
	minusOne := PjLiteralValueNode value: -1.
	one := PjLiteralValueNode value: 1.
	two := PjLiteralValueNode value: 2.
	three := PjLiteralValueNode value: 3.
	pi := PjLiteralValueNode value: 3.1415926.
	helloString := PjLiteralValueNode value: 'hello'.
	nilNode := PjNilNode new.
	trueNode := PjLiteralValueNode value: true.
	falseNode := PjLiteralValueNode value: false.
	selfNode := PjSelfNode new.
	selfNodeInBlock := PjSelfNode new inBlock: true;yourself.

	returnOne := PjReturnNode expression: one.
	returnTwo := PjReturnNode expression: two.
	returnThree := PjReturnNode expression: three.
	returnNil := PjReturnNode expression: nilNode.
	returnTrue := PjReturnNode expression: trueNode.
	returnFalse := PjReturnNode expression: falseNode.
	returnSelf := PjReturnNode expression: selfNode.

	throwOne := PjNonLocalReturnNode expression: one.
	throwTwo := PjNonLocalReturnNode expression: two.
	throwThree := PjNonLocalReturnNode expression: three.
	throwNil := PjNonLocalReturnNode expression: nilNode.
	throwSelf := PjNonLocalReturnNode expression: selfNode.

	foo := PjLiteralValueNode value: 'foo'.
	ClassVarForTest := PjClassVariableNode identifier: 'ClassVarForTest'.
	iv1ForTest := PjInstanceVariableNode identifier: #iv1ForTest.
	iv2ForTest := PjInstanceVariableNode identifier: #iv2ForTest.

]

{ #category : #testing }
PjAstTests >> simpleBlock: objectOrCollection locals: anArray [
	^ PjBlockNode 
		parameters: #()
		locals: anArray
		body: objectOrCollection
]

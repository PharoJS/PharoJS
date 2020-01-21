"
I have tests relating to classes that have implementations of some methods in another class
"
Class {
	#name : #PjReplacedClassTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #accessing }
PjReplacedClassTranspilationTest >> classToTranspile [
	^ PjReplacedClassForTest
]

{ #category : #testing }
PjReplacedClassTranspilationTest >> testClassReplacement [
	| prefix |
	prefix := PjTranspiler pharoJsSelectorPrefix.
	self deny: self jsCode includes: 'function ', className, '(){}'.
"We use defineProperty. See PjTranspiler>>#writeMethodsOf:named:with:"
	self assert: self jsCode includes: prefix, 'add_and_(op1,op2){return op2}'.
	self deny: self jsCode includes: 'notInPlaceholderClass'.
	self assert: self jsCode includes: prefix, '64_(op)'.
	self assert: self jsCode includes: prefix, 'm_($in)'.
	self assert: self jsCode includes: prefix, 'm1()'.
	self assert: self jsCode includes: prefix, 'm2()'.
	self assert: self jsCode includes: 'c$(function ', prefix, 'c1()'.
	self assert: self jsCode includes: 'c$(function ', prefix, 'c2()'.

]

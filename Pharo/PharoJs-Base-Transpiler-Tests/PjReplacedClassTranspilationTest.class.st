"
I have tests relating to classes that have implementations of some methods in another class
"
Class {
	#name : #PjReplacedClassTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #accessing }
PjReplacedClassTranspilationTest >> classToTranspile [
	^ PjReplacedClassForTest
]

{ #category : #testing }
PjReplacedClassTranspilationTest >> testClassReplacement [
	self deny: self jsCode includes: 'function ', className, '(){}'.
"We use defineProperty. See PjTranspiler>>#writeMethodsOf:named:with:"
	self assert: self jsCode includes: '_add_and_(op1,op2){return op2}'.
	self deny: self jsCode includes: 'notInPlaceholderClass'.
	self assert: self jsCode includes: '_64_(op)'.
	self assert: self jsCode includes: '_m_($in)'.
	self assert: self jsCode includes: '_m1()'.
	self assert: self jsCode includes: '_m2()'.
	self assert: self jsCode includes: 'c$(function _c1()'.
	self assert: self jsCode includes: 'c$(function _c2()'.
]

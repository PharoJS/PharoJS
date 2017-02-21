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
	self deny: self jsCode includes: 'function ', className, '(){}'.
"We use defineProperty. See PjTranspiler>>#writeMethodsOf:named:with:"
	self assert: self jsCode includes: '"_add_and_", {writable: true, value: function(op1,op2){return op2}'.
	self deny: self jsCode includes: 'notInPlaceholderClass'.
	self assert: self jsCode includes: '_64_", {writable: true, value: function(op)'.
	self assert: self jsCode includes: '_m_", {writable: true, value: function($in)'.
	self assert: self jsCode includes: '_m1", {writable: true, value: function()'.
	self assert: self jsCode includes: '_m2", {writable: true, value: function()'.
	self assert: self jsCode includes: className, '.__proto__, "_c1", {writable: true, value: function()'.
	self assert: self jsCode includes: className, '.__proto__, "_c2", {writable: true, value: function()'.

]

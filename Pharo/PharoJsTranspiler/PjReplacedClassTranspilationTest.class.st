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
	self assert: self jsCode includes: '_add_and_ = function(op1,op2){return op2}'.
	self deny: self jsCode includes: 'notInPlaceholderClass'.
	self assert: self jsCode includes: '_64_ = function(op)'.
	self assert: self jsCode includes: '_m_ = function($in)'.
	self assert: self jsCode includes: '_m1 = function()'.
	self assert: self jsCode includes: '_m2 = function()'.
	self assert: self jsCode includes: className, '.__proto__._c1 = function()'.
	self assert: self jsCode includes: className, '.__proto__._c2 = function()'.

]

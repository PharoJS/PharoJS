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
	self assert: self jsCode includes: PjTranspiler pharoJsSelectorPrefix, 'add_and_(op1,op2){return op2}'.
	self deny: self jsCode includes: 'notInPlaceholderClass'.
	self assert: self jsCode includes: PjTranspiler pharoJsSelectorPrefix, '64_(op)'.
	self assert: self jsCode includes: PjTranspiler pharoJsSelectorPrefix, 'm_($in)'.
	self assert: self jsCode includes: PjTranspiler pharoJsSelectorPrefix, 'm1()'.
	self assert: self jsCode includes: PjTranspiler pharoJsSelectorPrefix, 'm2()'.
	self assert: self jsCode includes: className, '.__proto__.$def(function pj_c1()'.
	self assert: self jsCode includes: className, '.__proto__.$def(function pj_c2()'.

]

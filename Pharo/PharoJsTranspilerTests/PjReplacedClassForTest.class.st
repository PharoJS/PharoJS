"
I contain methods to use as sources for various tests in PjTranspilationTests
"
Class {
	#name : #PjReplacedClassForTest,
	#superclass : #Object,
	#category : #'PharoJsTranspilerTests-Support'
}

{ #category : #'pharojs helper' }
PjReplacedClassForTest class >> javascriptPlaceholder [
	^ PjClassForTranspilationTest
]

{ #category : #any }
PjReplacedClassForTest >> add: op1 and: op2 [
	^op1 " note this is slightly different that the shadowed version "
]

{ #category : #any }
PjReplacedClassForTest >> notInPlaceholderClass [
]

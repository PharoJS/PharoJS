Class {
	#name : #PjLiteralGeneratorTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #accessing }
PjLiteralGeneratorTranspilationTest >> classToTranspile [
	^ PjClassForDefinitionTest
]

{ #category : #testing }
PjLiteralGeneratorTranspilationTest >> testLiteralGeneratrion [
	| pjPrefix |
	pjPrefix := transpiler pharoJsSelectorPrefix.
	self assert: self jsCode includes: 'i$(function ',pjPrefix,'literal(){return 7}'.
	self assert: self jsCode includes: 'c$(function ',pjPrefix,'literal(){return "abcdef"}'.

]

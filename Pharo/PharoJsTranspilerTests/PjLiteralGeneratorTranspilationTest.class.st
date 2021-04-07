Class {
	#name : #PjLiteralGeneratorTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJsTranspilerTests-Tests'
}

{ #category : #accessing }
PjLiteralGeneratorTranspilationTest >> classToTranspile [
	^ PjClassForDefinitionTest
]

{ #category : #testing }
PjLiteralGeneratorTranspilationTest >> testLiteralGeneratrion [
	self assert: self jsCode includes: 'i$(function _literal(){return 7}'.
	self assert: self jsCode includes: 'c$(function _literal(){return "abcdef"}'.

]

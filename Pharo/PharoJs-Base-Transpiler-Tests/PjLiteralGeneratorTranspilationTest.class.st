Class {
	#name : #PjLiteralGeneratorTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #accessing }
PjLiteralGeneratorTranspilationTest >> classToTranspile [
	^ PjClassForDefinitionTest
]

{ #category : #tests }
PjLiteralGeneratorTranspilationTest >> testLiteralGeneratrion [
	self assert: self jsCode includes: '_literal(){return 7}'.
	self assert: self jsCode includes: 'static _literal(){return "abcdef"}'.
]

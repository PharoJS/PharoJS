Class {
	#name : #PjClassDefinitionTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #accessing }
PjClassDefinitionTranspilationTest >> classToTranspile [
	^ PjClassForDefinitionTest
]

{ #category : #accessing }
PjClassDefinitionTranspilationTest >> expectedClassName [
	^self classToTranspile name
]

{ #category : #testing }
PjClassDefinitionTranspilationTest >> testClassDefinedAsConstructor [
	self assert: self jsCode includes: 'Object._subclass_("',className, '");'.
]

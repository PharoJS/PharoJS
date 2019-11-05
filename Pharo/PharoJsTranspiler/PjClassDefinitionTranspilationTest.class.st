Class {
	#name : #PjClassDefinitionTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJsTranspiler-Tests'
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
	self assert: self jsCode includes: 'Object.', PjTranspiler pharoJsSelectorPrefix, 'subclass_("',className, '");'.

]

Class {
	#name : #PjSharedPoolDefinitionTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #accessing }
PjSharedPoolDefinitionTranspilationTest >> classToTranspile [
	^ PjSharedPoolForTest
]

{ #category : #accessing }
PjSharedPoolDefinitionTranspilationTest >> expectedClassName [
	^ self classToTranspile name
]

{ #category : #testing }
PjSharedPoolDefinitionTranspilationTest >> testClassVariables [
	self assert: self jsCode includes: className, '.$$def('.
	self assert: self jsCode includes: 'cp$.A=cp$.B=cp$.C=cp$.X=null;'.
	self assert: self jsCode includes: 'cp$.A="sharedA"'.

]

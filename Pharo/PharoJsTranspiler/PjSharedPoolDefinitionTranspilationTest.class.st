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
	| classVarsHolder |
	classVarsHolder := className, '.', self classVariablesHolderName.
	self assert: self jsCode includes: '(',classVarsHolder,')'.
	self assert: self jsCode includes: '$$.A_=function($0){return $$.A=$0}'.
	self assert: self jsCode includes: '$$.A$=function(){return $$.A}'.
	self assert: self jsCode includes: '$$.B_=function($0){return $$.B=$0}'.
	self assert: self jsCode includes: '$$.B$=function(){return $$.B}'.
	self assert: self jsCode includes: '$$.X_=function($0){return $$.X=$0}'.
	self assert: self jsCode includes: '$$.X$=function(){return $$.X}'.

]

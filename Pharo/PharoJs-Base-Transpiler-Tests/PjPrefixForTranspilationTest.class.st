Class {
	#name : #PjPrefixForTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #accessing }
PjPrefixForTranspilationTest >> classToTranspile [
	^ PjClassForDefinitionTest
]

{ #category : #accessing }
PjPrefixForTranspilationTest >> selectorsPrefix [
	^ 'altPrefix_'
]

{ #category : #tests }
PjPrefixForTranspilationTest >> testPrefix [
	| pjPrefix |
	pjPrefix := self selectorsPrefix.
	self assert: self jsCode includes: pjPrefix,'literal(){'.
	self assert: self jsCode includes: 'static ',pjPrefix,'literal(){'.
]

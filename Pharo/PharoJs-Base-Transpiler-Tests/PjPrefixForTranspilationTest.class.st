Class {
	#name : #PjPrefixForTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #accessing }
PjPrefixForTranspilationTest >> classToTranspile [
	^ PjClassForDefinitionTest
]

{ #category : #testing }
PjPrefixForTranspilationTest >> selectorsPrefix [
	^ 'altPrefix_'
]

{ #category : #testing }
PjPrefixForTranspilationTest >> testPrefix [
	| pjPrefix |
	pjPrefix := self selectorsPrefix.
	self assert: self jsCode includes: 'i$(function ',pjPrefix,'literal(){'.
	self assert: self jsCode includes: 'c$(function ',pjPrefix,'literal(){'.
]

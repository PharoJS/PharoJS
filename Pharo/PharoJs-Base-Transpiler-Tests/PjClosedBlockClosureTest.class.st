Class {
	#name : #PjClosedBlockClosureTest,
	#superclass : #TestCase,
	#instVars : [
		'instVar'
	],
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #testing }
PjClosedBlockClosureTest >> testBlockFreeVariables [
	|x block closedBlock |
	x := 1.
	instVar := 42.
	block := [x := 99].
	self assert: block externalVariables keys asSet equals: #(x instVar block closedBlock testSelector expectedFails) asSet.
	closedBlock := block asClosedBlock.
	x := 2.
	instVar := 17.
	self assert: block asClosedBlock externalVariables equals: {#x->x. #instVar->instVar. #block->block. #closedBlock-> closedBlock. #testSelector->testSelector. #expectedFails->expectedFails} asDictionary.
	self assert: closedBlock externalVariables equals: {#x->1. #instVar->42. #block->block. #closedBlock-> nil. #testSelector->testSelector. #expectedFails->expectedFails} asDictionary.
]

{ #category : #testing }
PjClosedBlockClosureTest >> testBlockReferencingTempInMethod [
	|x closedBlock |
	x := 1.
	closedBlock := [x := 2] asClosedBlock.
	closedBlock value.
	self assert: x equals: 1.
]

{ #category : #testing }
PjClosedBlockClosureTest >> testClosingClosedBlock [
	| closedBlock |
	closedBlock := [] asClosedBlock.
	self assert: closedBlock asClosedBlock == closedBlock.
]

{ #category : #testing }
PjClosedBlockClosureTest >> testNestedBlockReferencingTempInMethod [
	|x closedBlock |
	x := 1.
	[closedBlock := [x := 2] asClosedBlock] value.
	closedBlock value.
	self assert: x equals: 1.
]

{ #category : #testing }
PjClosedBlockClosureTest >> testNestedBlockReferencingTempInOuterBlock [
	| xBlock closedBlock |
	xBlock := [|x|
		x := 1.
		closedBlock := [x := 2] asClosedBlock.
		[x]] value.
	closedBlock value.
	self assert: xBlock value equals: 1.
]

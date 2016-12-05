Class {
	#name : #PjAstOptimizationTest,
	#superclass : #PjAstTests,
	#category : #'PharoJsTranspilerOptimization-Tests'
}

{ #category : #testing }
PjAstOptimizationTest >> testNotTransformation [
	| v1 v2 |
	v1 := PjTempVariableNode identifier: #v1.
	v2 := PjTempVariableNode identifier: #v2.
	self assert: selfNode not equals: (PjUnaryNode operator: #! expression: selfNode).
	self assert: (PjUnaryNode operator: #! expression: selfNode) not equals: selfNode.
	self assert: selfNode not not equals: selfNode.
	self assert: (PjBinaryNode operator: #< left: v1 right: v2) not equals: (PjBinaryNode operator: #< left: v2 right: v1)

]

"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjIfNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'test'
	],
	#category : #'PharoJsTranspilerOptimization-AST'
}

{ #category : #creating }
PjIfNode class >> test: test [
	^ self new test: test; yourself
]

{ #category : #testing }
PjIfNode >> canPropogateReturns [
	^ true
]

{ #category : #accessing }
PjIfNode >> test [
	^ test
]

{ #category : #accessing }
PjIfNode >> test: anObject [
	test := anObject
]

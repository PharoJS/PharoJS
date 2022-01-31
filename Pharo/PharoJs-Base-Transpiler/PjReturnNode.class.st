"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjReturnNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'expression'
	],
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #creating }
PjReturnNode class >> expression: expression [
	^ self new expression: expression; yourself
]

{ #category : #visiting }
PjReturnNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitReturnNode: self
]

{ #category : #testing }
PjReturnNode >> canPropogateReturns [
	^ true
]

{ #category : #accessing }
PjReturnNode >> expression [
	^ expression
]

{ #category : #accessing }
PjReturnNode >> expression: anObject [
	expression := anObject
]

{ #category : #testing }
PjReturnNode >> isReturnOrThrow [
	^true
]

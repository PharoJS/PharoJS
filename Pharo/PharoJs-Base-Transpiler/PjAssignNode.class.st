"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjAssignNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'target',
		'expression'
	],
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #creating }
PjAssignNode class >> target: target expression: expression [
	^ self new target: target; expression: expression; yourself
]

{ #category : #visiting }
PjAssignNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitAssignNode: self
]

{ #category : #accessing }
PjAssignNode >> expression [
	^ expression
]

{ #category : #accessing }
PjAssignNode >> expression: anObject [
	expression := anObject
]

{ #category : #accessing }
PjAssignNode >> target [
	^ target
]

{ #category : #accessing }
PjAssignNode >> target: anObject [
	target := anObject
]

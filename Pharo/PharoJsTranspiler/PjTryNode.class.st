"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjTryNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'body'
	],
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #creating }
PjTryNode class >> body: body [
	^ self new body: body; yourself
]

{ #category : #visiting }
PjTryNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitTryNode: self
]

{ #category : #accessing }
PjTryNode >> body [
	^ body
]

{ #category : #accessing }
PjTryNode >> body: anObject [
	body := anObject asJsAstBody
]

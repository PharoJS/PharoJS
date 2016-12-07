"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjLiteralNode,
	#superclass : #PjJavascriptAstNode,
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #visiting }
PjLiteralNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitLiteralNode: self
]

{ #category : #testing }
PjLiteralNode >> isLiteralNode [
	^ true
]

{ #category : #testing }
PjLiteralNode >> isNonArray [
	^ true
]

{ #category : #testing }
PjLiteralNode >> isNonNilNode [
	^ true
]

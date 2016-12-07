"
I am an instance variable for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjInstanceVariableNode,
	#superclass : #PjVariableNode,
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #visiting }
PjInstanceVariableNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitInstanceVariableNode: self
]

{ #category : #testing }
PjInstanceVariableNode >> isLiteralSelector [
	^ true
]

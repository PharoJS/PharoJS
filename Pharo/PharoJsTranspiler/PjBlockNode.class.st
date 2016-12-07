"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjBlockNode,
	#superclass : #PjFunctionNode,
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #visiting }
PjBlockNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitBlockNode: self
]

"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjNonLocalReturnNode,
	#superclass : #PjReturnNode,
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #visiting }
PjNonLocalReturnNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitNonLocalReturnNode: self
]

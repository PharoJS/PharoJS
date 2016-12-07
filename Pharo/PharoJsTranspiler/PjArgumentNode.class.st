"
I am a parameter to a method or a block argument for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjArgumentNode,
	#superclass : #PjVariableNode,
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #visiting }
PjArgumentNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitArgumentNode: self
]

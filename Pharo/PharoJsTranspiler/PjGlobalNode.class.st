"
I am a globale variable for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjGlobalNode,
	#superclass : #PjVariableNode,
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #visiting }
PjGlobalNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitGlobalNode: self
]

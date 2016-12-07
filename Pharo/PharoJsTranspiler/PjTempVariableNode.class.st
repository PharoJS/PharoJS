"
I am a temporary variable in a method for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjTempVariableNode,
	#superclass : #PjVariableNode,
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #visiting }
PjTempVariableNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitTempVariableNode: self
]

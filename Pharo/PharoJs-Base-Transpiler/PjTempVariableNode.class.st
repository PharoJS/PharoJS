"
I am a temporary variable in a method for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjTempVariableNode,
	#superclass : #PjVariableNode,
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #visiting }
PjTempVariableNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitTempVariableNode: self
]

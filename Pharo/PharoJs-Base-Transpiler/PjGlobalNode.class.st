"
I am a globale variable for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjGlobalNode,
	#superclass : #PjVariableNode,
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #visiting }
PjGlobalNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitGlobalNode: self
]

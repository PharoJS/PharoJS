Class {
	#name : #PjPoolVariableNode,
	#superclass : #PjClassVariableNode,
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #visiting }
PjPoolVariableNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitPoolVariableNode: self
]

{ #category : #testing }
PjPoolVariableNode >> isNonlocalClassOrPoolVariableReference: aClass [
	^ true
]

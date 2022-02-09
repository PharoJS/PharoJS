"
I am a class node (a global class) for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjClassNode,
	#superclass : #PjVariableNode,
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #visiting }
PjClassNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitClassNode: self
]

{ #category : #testing }
PjClassNode >> isNonArray [
	^ true
]

{ #category : #testing }
PjClassNode >> isNonNilNode [
	^ true
]

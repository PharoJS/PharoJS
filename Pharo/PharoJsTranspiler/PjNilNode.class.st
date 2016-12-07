"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjNilNode,
	#superclass : #PjLiteralNode,
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #visiting }
PjNilNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitNilNode: self
]

{ #category : #testing }
PjNilNode >> isNonNilNode [
	^ false
]

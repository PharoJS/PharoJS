"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjSuperNode,
	#superclass : #PjSelfNode,
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #visiting }
PjSuperNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitSuperNode: self
]

{ #category : #testing }
PjSuperNode >> isSuperSend [
	^ true
]

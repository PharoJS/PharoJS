"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : 'PjNilNode',
	#superclass : 'PjLiteralNode',
	#category : 'PharoJs-Base-Transpiler-AST',
	#package : 'PharoJs-Base-Transpiler',
	#tag : 'AST'
}

{ #category : 'visiting' }
PjNilNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitNilNode: self
]

{ #category : 'testing' }
PjNilNode >> isNonNilNode [
	^ false
]

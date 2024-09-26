"
I am an instance variable for visiting with a subclass of PjASTVisitor
"
Class {
	#name : 'PjInstanceVariableNode',
	#superclass : 'PjVariableNode',
	#category : 'PharoJs-Base-Transpiler-AST',
	#package : 'PharoJs-Base-Transpiler',
	#tag : 'AST'
}

{ #category : 'visiting' }
PjInstanceVariableNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitInstanceVariableNode: self
]

{ #category : 'testing' }
PjInstanceVariableNode >> isLiteralSelector [
	^ true
]

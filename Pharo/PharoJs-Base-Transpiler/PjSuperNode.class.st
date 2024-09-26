"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : 'PjSuperNode',
	#superclass : 'PjSelfNode',
	#category : 'PharoJs-Base-Transpiler-AST',
	#package : 'PharoJs-Base-Transpiler',
	#tag : 'AST'
}

{ #category : 'visiting' }
PjSuperNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitSuperNode: self
]

{ #category : 'testing' }
PjSuperNode >> isSuperSend [
	^ true
]

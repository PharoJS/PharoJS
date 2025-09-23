"
I am a pool variable for visiting with a subclass of PjASTVisitor
"
Class {
	#name : 'PjPoolVariableNode',
	#superclass : 'PjClassVariableNode',
	#category : 'PharoJs-Base-Transpiler-AST',
	#package : 'PharoJs-Base-Transpiler',
	#tag : 'AST'
}

{ #category : 'visiting' }
PjPoolVariableNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitPoolVariableNode: self
]

{ #category : 'testing' }
PjPoolVariableNode >> isNonlocalClassOrPoolVariableReference: aClass [
	^ true
]

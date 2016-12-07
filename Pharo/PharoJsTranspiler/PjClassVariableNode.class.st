"
I am a class variable for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjClassVariableNode,
	#superclass : #PjVariableNode,
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #visiting }
PjClassVariableNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitClassVariableNode: self
]

{ #category : #testing }
PjClassVariableNode >> isLiteralSelector [
	^ true
]

{ #category : #testing }
PjClassVariableNode >> isNonlocalClassOrPoolVariableReference: aClass [
	myClass ifNil: [ ^ true ].
	^ aClass ~= myClass theMetaClass
]

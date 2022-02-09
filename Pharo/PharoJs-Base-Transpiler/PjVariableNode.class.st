"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjVariableNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'identifier'
	],
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #creating }
PjVariableNode class >> identifier: identifier [
	^ self new identifier: identifier; yourself
]

{ #category : #visiting }
PjVariableNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitVariableNode: self
]

{ #category : #accessing }
PjVariableNode >> identifier [
	^ identifier
]

{ #category : #accessing }
PjVariableNode >> identifier: anObject [
	identifier := anObject
]

{ #category : #testing }
PjVariableNode >> valuesToCompareForSimilarity [
	^self identifier
]

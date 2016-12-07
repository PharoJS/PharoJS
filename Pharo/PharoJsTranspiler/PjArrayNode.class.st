"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjArrayNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'expressions'
	],
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #creating }
PjArrayNode class >> expressions: sequence [
	^ self new expressions: sequence asArray; yourself
]

{ #category : #visiting }
PjArrayNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitArrayNode: self
]

{ #category : #accessing }
PjArrayNode >> expressions [
	^ expressions
]

{ #category : #accessing }
PjArrayNode >> expressions: anObject [
	expressions := anObject
]

{ #category : #testing }
PjArrayNode >> isNonNilNode [
	^ true
]

{ #category : #accessing }
PjArrayNode >> valuesToCompareForSimilarity [
	^self expressions
]

"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjMessageSelectorNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'identifier'
	],
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #creating }
PjMessageSelectorNode class >> identifier: identifier [
	^ self new identifier: identifier; yourself
]

{ #category : #visiting }
PjMessageSelectorNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitMessageSelectorNode: self
]

{ #category : #accessing }
PjMessageSelectorNode >> identifier [
	^ identifier
]

{ #category : #accessing }
PjMessageSelectorNode >> identifier: anObject [
	identifier := anObject
]

{ #category : #testing }
PjMessageSelectorNode >> isLiteralSelector [
	^ true
]

{ #category : #testing }
PjMessageSelectorNode >> valuesToCompareForSimilarity [
	^self identifier
]

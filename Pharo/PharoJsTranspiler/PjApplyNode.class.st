"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjApplyNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'func',
		'args'
	],
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #creating }
PjApplyNode class >> func: func args: args [
	^ self new func: func; args: (args ifNotNil: [ args asArray]); yourself
]

{ #category : #creating }
PjApplyNode class >> receiver: receiverNode selector: aSymbol args: args [
	^self 
		func: (PjFieldNode target: receiverNode selectorNode: (PjMessageSelectorNode identifier: aSymbol asSymbol) isNonNil: receiverNode isNonNilNode)
		args: args
]

{ #category : #visiting }
PjApplyNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitApplyNode: self
]

{ #category : #accessing }
PjApplyNode >> args [
	^ args
]

{ #category : #accessing }
PjApplyNode >> args: anObject [
	args := anObject
]

{ #category : #accessing }
PjApplyNode >> func [
	^ func
]

{ #category : #accessing }
PjApplyNode >> func: anObject [
	func := anObject
]

{ #category : #comparing }
PjApplyNode >> valuesToCompareForSimilarity [
	^{self func}, self args
]

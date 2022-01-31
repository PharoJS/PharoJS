"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjSequenceNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'expressions'
	],
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #creating }
PjSequenceNode class >> expressions: expressions [
	^ self new expressions: expressions asArray; yourself
]

{ #category : #visiting }
PjSequenceNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitSequenceNode: self
]

{ #category : #adding }
PjSequenceNode >> addLast: astNode [
	expressions := expressions, {astNode}
]

{ #category : #converting }
PjSequenceNode >> asJsAstBody [
	^ self expressions asArray
]

{ #category : #accessing }
PjSequenceNode >> asSimpleNode [
	expressions size = 1 ifTrue: [ ^ expressions first asSimpleNode ].
	^ self
]

{ #category : #testing }
PjSequenceNode >> canPropogateReturns [
	^ expressions notEmpty and: [ expressions last canPropogateReturns ]
]

{ #category : #accessing }
PjSequenceNode >> expressions [
	^ expressions
]

{ #category : #accessing }
PjSequenceNode >> expressions: anObject [
	expressions := anObject
]

{ #category : #testing }
PjSequenceNode >> isEmpty [
	^ self expressions isEmptyOrNil
]

{ #category : #testing }
PjSequenceNode >> isNot [
	^ expressions notEmpty and: [ expressions last isNot ]
]

{ #category : #converting }
PjSequenceNode >> not [
	^ self class expressions: self expressions allButLast, {self expressions last not}
]

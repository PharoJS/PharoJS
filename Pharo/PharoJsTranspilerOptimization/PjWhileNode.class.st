"
I am part of the representation of a Javascript AST for visiting
"
Class {
	#name : #PjWhileNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'test',
		'body'
	],
	#category : #'PharoJsTranspilerOptimization-AST'
}

{ #category : #creating }
PjWhileNode class >> test: test body: body [
	^ self new test: test; body: body asArray; yourself
]

{ #category : #visiting }
PjWhileNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitWhileNode: self
]

{ #category : #accessing }
PjWhileNode >> body [
	^ body
]

{ #category : #accessing }
PjWhileNode >> body: anObject [
	body := anObject
]

{ #category : #testing }
PjWhileNode >> canPropogateReturns [
	^ true " not really, but we don't want to add a 'return this' at the end "
]

{ #category : #accessing }
PjWhileNode >> test [
	^ test
]

{ #category : #accessing }
PjWhileNode >> test: anObject [
	test := anObject
]

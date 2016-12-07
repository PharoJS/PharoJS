"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjUnaryNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'operator',
		'expression'
	],
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #creating }
PjUnaryNode class >> operator: operator expression: expression [
	^ self new operator: operator; expression: expression; yourself
]

{ #category : #visiting }
PjUnaryNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitUnaryNode: self
]

{ #category : #accessing }
PjUnaryNode >> expression [
	^ expression
]

{ #category : #accessing }
PjUnaryNode >> expression: anObject [
	expression := anObject
]

{ #category : #testing }
PjUnaryNode >> isNot [
	^ operator = #!
]

{ #category : #rewriting }
PjUnaryNode >> not [
	operator = #! ifTrue: [  ^ expression ].
	^ super not
]

{ #category : #accessing }
PjUnaryNode >> operator [
	^ operator
]

{ #category : #accessing }
PjUnaryNode >> operator: anObject [
	operator := anObject
]

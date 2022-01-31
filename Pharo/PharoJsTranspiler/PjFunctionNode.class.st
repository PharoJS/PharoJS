"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjFunctionNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'parameters',
		'locals',
		'body'
	],
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #creating }
PjFunctionNode class >> parameters: parameters locals: locals body: body [
	^ self new parameters: parameters asArray; locals: locals asArray; body: body asJsAstBody; yourself
]

{ #category : #visiting }
PjFunctionNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitFunctionNode: self
]

{ #category : #accessing }
PjFunctionNode >> addLocal: anObject [
	locals := locals asOrderedCollection.
	^ locals add: anObject
]

{ #category : #accessing }
PjFunctionNode >> body [
	^ body
]

{ #category : #accessing }
PjFunctionNode >> body: anObject [
	body := anObject
]

{ #category : #testing }
PjFunctionNode >> isNonNilNode [
	^ true
]

{ #category : #accessing }
PjFunctionNode >> locals [
	^ locals
]

{ #category : #accessing }
PjFunctionNode >> locals: anObject [
	locals := anObject
]

{ #category : #testing }
PjFunctionNode >> needsSelf [
	^ false
]

{ #category : #accessing }
PjFunctionNode >> parameters [
	^ parameters
]

{ #category : #accessing }
PjFunctionNode >> parameters: anObject [
	parameters := anObject
]

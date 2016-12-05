"
I am part of the representation of a Javascript AST for visiting
"
Class {
	#name : #PjForLoopNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'from',
		'to',
		'by',
		'body'
	],
	#category : #'PharoJsTranspilerOptimization-AST'
}

{ #category : #creation }
PjForLoopNode class >> from: from to: to by: by body: body [
	^ self new from: from; to: to; by: by; body: body
]

{ #category : #visiting }
PjForLoopNode >> acceptVisitor: aPjStringGenerator [
	^ aPjStringGenerator visitToDoByNode: self
]

{ #category : #accessing }
PjForLoopNode >> body [
	^ body
]

{ #category : #accessing }
PjForLoopNode >> body: aCollection [
	body := aCollection
]

{ #category : #accessing }
PjForLoopNode >> by [
	^ by
]

{ #category : #accessing }
PjForLoopNode >> by: aPjAstNode [
	by := aPjAstNode
]

{ #category : #testing }
PjForLoopNode >> canPropogateReturns [
	^ true
]

{ #category : #accessing }
PjForLoopNode >> from [
	^ from
]

{ #category : #accessing }
PjForLoopNode >> from: aPjAstNode [
	from := aPjAstNode
]

{ #category : #accessing }
PjForLoopNode >> to [
	^ to
]

{ #category : #accessing }
PjForLoopNode >> to: aPjAstNode [
	to := aPjAstNode
]

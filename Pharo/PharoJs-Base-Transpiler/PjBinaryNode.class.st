"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjBinaryNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'operator',
		'left',
		'right'
	],
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #creating }
PjBinaryNode class >> operator: operator left: left right: right [
	^ self new operator: operator; left: left; right: right; yourself
]

{ #category : #visiting }
PjBinaryNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitBinaryNode: self
]

{ #category : #rewriting }
PjBinaryNode >> copyWith: newOperator [
	^ self class operator: newOperator left: left right: right
]

{ #category : #testing }
PjBinaryNode >> isComparison [
	^ #(== != === !== <= >= < > ) includes: operator
]

{ #category : #accessing }
PjBinaryNode >> left [
	^ left
]

{ #category : #accessing }
PjBinaryNode >> left: anObject [
	left := anObject
]

{ #category : #rewriting }
PjBinaryNode >> not [
	operator = #== ifTrue: [  ^ self copyWith: #!= ].
	operator = #!= ifTrue: [  ^ self copyWith: #== ].
	operator = #=== ifTrue: [  ^ self copyWith: #!== ].
	operator = #!== ifTrue: [  ^ self copyWith: #=== ].
	(#( <= >= < > ) includes: operator) ifTrue: [ ^ self class operator: operator left: right right: left].
	^ super not
]

{ #category : #accessing }
PjBinaryNode >> operator [
	^ operator
]

{ #category : #accessing }
PjBinaryNode >> operator: anObject [
	operator := anObject
]

{ #category : #accessing }
PjBinaryNode >> right [
	^ right
]

{ #category : #accessing }
PjBinaryNode >> right: anObject [
	right := anObject
]

{ #category : #comparing }
PjBinaryNode >> valuesToCompareForEquality [
	^{self operator. self left. self right}
]

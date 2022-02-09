"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjIfTrueNode,
	#superclass : #PjIfNode,
	#instVars : [
		'whenTrue'
	],
	#category : #'PharoJs-Base-Transpiler-Optimizations-AST'
}

{ #category : #creating }
PjIfTrueNode class >> test: test whenTrue: whenTrue [
	^ self new test: test; whenTrue: whenTrue; yourself
]

{ #category : #visiting }
PjIfTrueNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitIfTrueNode: self
]

{ #category : #accessing }
PjIfTrueNode >> whenTrue [
	^ whenTrue
]

{ #category : #accessing }
PjIfTrueNode >> whenTrue: anObject [
	whenTrue := anObject
]

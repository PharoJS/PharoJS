"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjIfTrueIfFalseNode,
	#superclass : #PjIfTrueNode,
	#instVars : [
		'whenFalse'
	],
	#category : #'PharoJsTranspilerOptimization-AST'
}

{ #category : #creating }
PjIfTrueIfFalseNode class >> test: test whenTrue: whenTrue whenFalse: whenFalse [
	^ self new test: test; whenTrue: whenTrue; whenFalse: whenFalse; yourself
]

{ #category : #visiting }
PjIfTrueIfFalseNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitIfTrueIfFalseNode: self
]

{ #category : #accessing }
PjIfTrueIfFalseNode >> whenFalse [
	^ whenFalse
]

{ #category : #accessing }
PjIfTrueIfFalseNode >> whenFalse: anObject [
	whenFalse := anObject
]

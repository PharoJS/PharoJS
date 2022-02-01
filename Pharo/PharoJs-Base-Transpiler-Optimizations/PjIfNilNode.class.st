"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjIfNilNode,
	#superclass : #PjIfNode,
	#instVars : [
		'whenNil'
	],
	#category : #'PharoJs-Base-Transpiler-Optimizations-AST'
}

{ #category : #creating }
PjIfNilNode class >> test: test whenNil: whenNil [
	^ self new test: test; whenNil: whenNil; yourself
]

{ #category : #visiting }
PjIfNilNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitIfNilNode: self
]

{ #category : #accessing }
PjIfNilNode >> whenNil [
	^ whenNil
]

{ #category : #accessing }
PjIfNilNode >> whenNil: anObject [
	whenNil := anObject
]

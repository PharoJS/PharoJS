"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjIfNilIfNotNilNode,
	#superclass : #PjIfNotNilNode,
	#instVars : [
		'whenNil'
	],
	#category : #'PharoJsTranspilerOptimization-AST'
}

{ #category : #creating }
PjIfNilIfNotNilNode class >> test: test whenNotNil: whenNotNil whenNil: whenNil [
	^ self new test: test; whenNotNil: whenNotNil; whenNil: whenNil; yourself
]

{ #category : #visiting }
PjIfNilIfNotNilNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitIfNilIfNotNilNode: self
]

{ #category : #accessing }
PjIfNilIfNotNilNode >> whenNil [
	^ whenNil
]

{ #category : #accessing }
PjIfNilIfNotNilNode >> whenNil: anObject [
	whenNil := anObject
]

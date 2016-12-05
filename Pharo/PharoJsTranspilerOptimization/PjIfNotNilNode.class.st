"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjIfNotNilNode,
	#superclass : #PjIfNode,
	#instVars : [
		'whenNotNil'
	],
	#category : #'PharoJsTranspilerOptimization-AST'
}

{ #category : #creating }
PjIfNotNilNode class >> test: test whenNotNil: whenNotNil [
	^ self new test: test; whenNotNil: whenNotNil; yourself
]

{ #category : #visiting }
PjIfNotNilNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitIfNotNilNode: self
]

{ #category : #accessing }
PjIfNotNilNode >> whenNotNil [
	^ whenNotNil
]

{ #category : #accessing }
PjIfNotNilNode >> whenNotNil: anObject [
	whenNotNil := anObject
]

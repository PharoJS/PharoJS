"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjLiteralValueNode,
	#superclass : #PjLiteralNode,
	#instVars : [
		'value'
	],
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #creating }
PjLiteralValueNode class >> value: value [
	^ self new value: value; yourself
]

{ #category : #visiting }
PjLiteralValueNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitLiteralValueNode: self
]

{ #category : #testing }
PjLiteralValueNode >> isNonArray [
	(myClass inheritsFrom: String) ifTrue: [ ^ true ].
	^ (myClass inheritsFrom: Collection) not
]

{ #category : #accessing }
PjLiteralValueNode >> value [
	^ value
]

{ #category : #accessing }
PjLiteralValueNode >> value: anObject [
	value := anObject.
	myClass := anObject class
]

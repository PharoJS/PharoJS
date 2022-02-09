"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjSelfNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'inBlock'
	],
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #creating }
PjSelfNode class >> inBlock: inBlock [
	^ self new inBlock: inBlock; yourself
]

{ #category : #visiting }
PjSelfNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitSelfNode: self
]

{ #category : #accessing }
PjSelfNode >> inBlock [
	^ inBlock
]

{ #category : #accessing }
PjSelfNode >> inBlock: anObject [
	inBlock := anObject
]

{ #category : #initializing }
PjSelfNode >> initialize [
	inBlock := false
]

{ #category : #testing }
PjSelfNode >> isNonArray [
	(myClass inheritsFrom: String) ifTrue: [ ^ true ].
	^ (myClass inheritsFrom: Collection) not
]

{ #category : #testing }
PjSelfNode >> isNonNilNode [
	^ true
]

{ #category : #testing }
PjSelfNode >> isSelfNode [
	^ true
]

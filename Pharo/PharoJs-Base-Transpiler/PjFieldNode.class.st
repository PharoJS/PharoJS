"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : #PjFieldNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'target',
		'selectorNode',
		'isNonNil'
	],
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #creating }
PjFieldNode class >> target: target selectorNode: selectorNode isNonNil: isNonNil [
	^ self new target: target; selectorNode: selectorNode; isNonNil: isNonNil; yourself
]

{ #category : #visiting }
PjFieldNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitFieldNode: self
]

{ #category : #accessing }
PjFieldNode >> isNonNil [
	^ isNonNil
]

{ #category : #accessing }
PjFieldNode >> isNonNil: anObject [
	isNonNil := anObject
]

{ #category : #testing }
PjFieldNode >> isNonlocalClassOrPoolVariableReference: aClass [
	^ selectorNode isNonlocalClassOrPoolVariableReference: aClass
]

{ #category : #testing }
PjFieldNode >> isSuperSend [
	^ target isSuperSend
]

{ #category : #accessing }
PjFieldNode >> selectorNode [
	^ selectorNode
]

{ #category : #accessing }
PjFieldNode >> selectorNode: anObject [
	selectorNode := anObject
]

{ #category : #accessing }
PjFieldNode >> target [
	^ target
]

{ #category : #accessing }
PjFieldNode >> target: anObject [
	target := anObject
]

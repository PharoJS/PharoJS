"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjMethodNode,
	#superclass : #PjFunctionNode,
	#instVars : [
		'methodName',
		'needsSelf',
		'isClassMethod'
	],
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #creating }
PjMethodNode class >> methodName: methodName body: body [
	^ self parameters: #() locals: #() body: body methodName: methodName needsSelf: false isClassMethod: false
]

{ #category : #creating }
PjMethodNode class >> parameters: parameters locals: locals body: body methodName: methodName needsSelf: needsSelf isClassMethod: isClassMethod [
	^ (self parameters: parameters locals: locals body: body) needsSelf: needsSelf; methodName: methodName; isClassMethod: isClassMethod; yourself
]

{ #category : #visiting }
PjMethodNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitMethodNode: self
]

{ #category : #accessing }
PjMethodNode >> isClassMethod [
	^ isClassMethod
]

{ #category : #accessing }
PjMethodNode >> isClassMethod: anObject [
	isClassMethod := anObject
]

{ #category : #accessing }
PjMethodNode >> methodName [
	^ methodName
]

{ #category : #accessing }
PjMethodNode >> methodName: anObject [
	methodName := anObject
]

{ #category : #accessing }
PjMethodNode >> needsSelf [
	^ needsSelf
]

{ #category : #accessing }
PjMethodNode >> needsSelf: anObject [
	needsSelf := anObject
]

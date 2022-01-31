"
I am a class variable for visiting with a subclass of PjASTVisitor
"
Class {
	#name : #PjClassVariableNode,
	#superclass : #PjVariableNode,
	#instVars : [
		'poolReference'
	],
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #visiting }
PjClassVariableNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitClassVariableNode: self
]

{ #category : #testing }
PjClassVariableNode >> isLiteralSelector [
	^ true
]

{ #category : #testing }
PjClassVariableNode >> isNonlocalClassOrPoolVariableReference: aClass [
	myClass ifNil: [ ^ true ].
	^ aClass ~= myClass classSide
]

{ #category : #accessing }
PjClassVariableNode >> poolReference [
	^ poolReference
]

{ #category : #accessing }
PjClassVariableNode >> poolReference: aClass [ 
	poolReference := aClass instanceSide
]

{ #category : #converting }
PjClassVariableNode >> poolReferenceWith: aPjTranspiler [ 
	^ aPjTranspiler poolReference: poolReference for: myClass
]

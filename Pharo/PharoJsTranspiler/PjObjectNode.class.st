"
I produce a Javascript object with fields from my dictionary
"
Class {
	#name : #PjObjectNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'dictionary'
	],
	#category : #'PharoJsTranspiler-AST'
}

{ #category : #creating }
PjObjectNode class >> dictionary: dictionary [
	^ self new dictionary: dictionary; yourself
]

{ #category : #visiting }
PjObjectNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitObjectNode: self
]

{ #category : #accessing }
PjObjectNode >> dictionary [
	^ dictionary
]

{ #category : #accessing }
PjObjectNode >> dictionary: anObject [
	dictionary := anObject
]

{ #category : #testing }
PjObjectNode >> isNonArray [
	^ true
]

{ #category : #testing }
PjObjectNode >> isNonNilNode [
	^ true
]

"
I contain strings that ahould go literally into the output stream
"
Class {
	#name : #PjUnparsedStringNode,
	#superclass : #PjJavascriptAstNode,
	#instVars : [
		'string'
	],
	#category : #'PharoJs-Base-Transpiler-AST'
}

{ #category : #creating }
PjUnparsedStringNode class >> string: string [
	^ self new string: string; yourself
]

{ #category : #visiting }
PjUnparsedStringNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitUnparsedStringNode: self
]

{ #category : #converting }
PjUnparsedStringNode >> asJsAstUsing: astConverter [
	^ self
]

{ #category : #accessing }
PjUnparsedStringNode >> string [
	^ string
]

{ #category : #accessing }
PjUnparsedStringNode >> string: anObject [
	string := anObject
]

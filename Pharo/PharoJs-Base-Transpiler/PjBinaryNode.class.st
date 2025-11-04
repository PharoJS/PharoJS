"
I am part of the representation of a Javascript AST for visiting with a subclass of PjASTVisitor or PjASTEqual
"
Class {
	#name : 'PjBinaryNode',
	#superclass : 'PjJavascriptAstNode',
	#instVars : [
		'operator',
		'left',
		'right'
	],
	#classVars : [
		'NegationMappingDict'
	],
	#category : 'PharoJs-Base-Transpiler-AST',
	#package : 'PharoJs-Base-Transpiler',
	#tag : 'AST'
}

{ #category : 'accessing' }
PjBinaryNode class >> negationMappingAssociations [

	^ {
		  (#'==' -> #'!=').
		  (#'!=' -> #'==').
		  (#'===' -> #'!==').
		  (#'!==' -> #'===').
		  (#'<=' -> #>).
		  (#< -> #'>=').
		  (#> -> #'<=').
		  (#'>=' -> #<) }
]

{ #category : 'accessing' }
PjBinaryNode class >> negationMappingDict [

	^ NegationMappingDict ifNil: [
		  NegationMappingDict := self negationMappingAssociations asDictionary ]
]

{ #category : 'creating' }
PjBinaryNode class >> operator: operator left: left right: right [
	^ self new operator: operator; left: left; right: right; yourself
]

{ #category : 'visiting' }
PjBinaryNode >> acceptVisitor: aPjASTVisitor [
	^ aPjASTVisitor visitBinaryNode: self
]

{ #category : 'rewriting' }
PjBinaryNode >> copyWith: newOperator [
	^ self class operator: newOperator left: left right: right
]

{ #category : 'testing' }
PjBinaryNode >> isComparison [
	^ #(== != === !== <= >= < > ) includes: operator
]

{ #category : 'accessing' }
PjBinaryNode >> left [
	^ left
]

{ #category : 'accessing' }
PjBinaryNode >> left: anObject [
	left := anObject
]

{ #category : 'accessing' }
PjBinaryNode >> negationMappingDict [
	^self class negationMappingDict
]

{ #category : 'converting' }
PjBinaryNode >> not [

	| inverseOperator |
	inverseOperator := self negationMappingDict
		                   at: operator
		                   ifAbsent: [ ^ super not ].
	^ self copyWith: inverseOperator
]

{ #category : 'accessing' }
PjBinaryNode >> operator [
	^ operator
]

{ #category : 'accessing' }
PjBinaryNode >> operator: anObject [
	operator := anObject
]

{ #category : 'accessing' }
PjBinaryNode >> right [
	^ right
]

{ #category : 'accessing' }
PjBinaryNode >> right: anObject [
	right := anObject
]

{ #category : 'comparing' }
PjBinaryNode >> valuesToCompareForEquality [
	^{self operator. self left. self right}
]

"
I encode a Javascript AST ready to be output.

Used also for test to see if the transpilation makes the right AST

"
Class {
	#name : #PjJavascriptAstNode,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'myClass'
	],
	#category : #'PharoJsTranspiler-Kernel'
}

{ #category : #creating }
PjJavascriptAstNode class >> myClass: anInteger [
	^ self new myClass: anInteger;yourself
]

{ #category : #visiting }
PjJavascriptAstNode >> acceptVisitor: aPjASTVisitor [
	self subclassResponsibility
]

{ #category : #converting }
PjJavascriptAstNode >> asJsAstBody [
	^{self}
]

{ #category : #accessing }
PjJavascriptAstNode >> asSimpleNode [
	^ self
]

{ #category : #testing }
PjJavascriptAstNode >> canPropogateReturns [
	^ false
]

{ #category : #'as yet unclassified' }
PjJavascriptAstNode >> expressions [
	^ { self }
]

{ #category : #testing }
PjJavascriptAstNode >> isComparison [
	^ false
]

{ #category : #testing }
PjJavascriptAstNode >> isLiteralNode [
	^ false
]

{ #category : #testing }
PjJavascriptAstNode >> isLiteralSelector [
	^ false
]

{ #category : #testing }
PjJavascriptAstNode >> isNonNil [
	^ self isNonNilNode
]

{ #category : #testing }
PjJavascriptAstNode >> isNonNilNode [
	^ false
]

{ #category : #testing }
PjJavascriptAstNode >> isNonlocalClassOrPoolVariableReference: aClass [
	^ false
]

{ #category : #testing }
PjJavascriptAstNode >> isNot [
	^ false
]

{ #category : #testing }
PjJavascriptAstNode >> isPjJavascriptAstNode [
	^true
]

{ #category : #testing }
PjJavascriptAstNode >> isReturnOrThrow [
	^false
]

{ #category : #testing }
PjJavascriptAstNode >> isSelfNode [
	^ false
]

{ #category : #comparing }
PjJavascriptAstNode >> isSimilarTo: anObject [ 
	| myValues otherValues |
	self species = anObject species ifFalse: [^false].
	myValues := self valuesToCompareForSimilarity.
	otherValues := anObject valuesToCompareForSimilarity.
	myValues size = otherValues size ifFalse: [ ^false ].
	myValues
		with: otherValues
		do: [ : myValue : otherValue | 
			(myValue isSimilarTo: otherValue) ifFalse: [^false]].
	^true.
]

{ #category : #testing }
PjJavascriptAstNode >> isSuperSend [
	^ false
]

{ #category : #accessing }
PjJavascriptAstNode >> myClass [
	^ myClass
]

{ #category : #accessing }
PjJavascriptAstNode >> myClass: anObject [
	myClass := anObject
]

{ #category : #converting }
PjJavascriptAstNode >> not [
	^ PjUnaryNode operator: #! expression: self
]

{ #category : #printing }
PjJavascriptAstNode >> printOn: aStream [
	| instVars needParens |
	instVars := self class allInstVarNames copyWithoutAll: #(myClass inBlock).
	needParens := instVars size > 0 and: [ aStream size >0 ].
	aStream
		nextPutAll: (needParens ifTrue: [ '(' ] ifFalse: [ '' ]);
		nextPutAll: self className.
	instVars ifEmpty: [ aStream nextPutAll: ' new' ].
	instVars do: [: name | | value |
		aStream space;nextPutAll: name;nextPut: $:.
		value := self instVarNamed: name.
		(value isCollection and: [value isString not]) ifTrue: [
			aStream nextPut: ${.
			value do: [: each |
					aStream nextPutAll: each asString
				] separatedBy: [ aStream nextPut: $. ].
			aStream nextPut: $}.
		] ifFalse: [
			value printOn: aStream]
	].
	aStream
		nextPutAll: (needParens ifTrue: [ ')' ] ifFalse: [ '' ])
]

{ #category : #comparing }
PjJavascriptAstNode >> valuesToCompareForSimilarity [
	^ self valuesToCompareForEquality select: [ : each | each isPjJavascriptAstNode ]
]

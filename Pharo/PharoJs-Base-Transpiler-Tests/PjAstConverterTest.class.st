"
I'm an abstract test class
"
Class {
	#name : #PjAstConverterTest,
	#superclass : #PjAbstractAstTest,
	#instVars : [
		'converter'
	],
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #checking }
PjAstConverterTest >> assertContentsOf: aBlock convertsTo: expectedJsAst [
	| actualJsAst |
	actualJsAst := self convertFirstStatementOfBlock: aBlock.
	self assert: actualJsAst equals: expectedJsAst.
]

{ #category : #checking }
PjAstConverterTest >> assertMethod: methodSymbol convertsTo: expectedJsAst [
	| actualJsAst |
	actualJsAst := converter convertFirstStatementOfBlock: (PjClassForAstConversionTest>>methodSymbol) ast.
	self assert: actualJsAst equals: expectedJsAst.
]

{ #category : #checking }
PjAstConverterTest >> convertFirstStatementOfBlock: aBlock [
	^ converter convertFirstStatementOfBlock: aBlock firstAstNode
]

{ #category : #'test mock' }
PjAstConverterTest >> discoveredMessage: aString [
	" just here so tests don't fail "
]

{ #category : #accessing }
PjAstConverterTest >> discoveredReferenceToClass: aClass [
]

{ #category : #checking }
PjAstConverterTest >> failConverting: aBlock [
	self should: [ self convertFirstStatementOfBlock: aBlock ] raise: Exception
]

{ #category : #running }
PjAstConverterTest >> setUp [
	super setUp.
	converter := PjAstConverter new transpiler: self;yourself.
]

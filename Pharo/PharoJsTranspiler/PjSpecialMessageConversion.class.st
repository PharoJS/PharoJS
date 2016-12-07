"
I am an abstract class for PjAST optimizations

"
Class {
	#name : #PjSpecialMessageConversion,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'order',
		'messageConverter'
	],
	#category : #'PharoJsTranspiler-Kernel'
}

{ #category : #accessing }
PjSpecialMessageConversion >> astConverter [
	^self messageConverter astConverter
]

{ #category : #converting }
PjSpecialMessageConversion >> convertReceiver: receiver args: args [
	" return a replacement AST or nil if there's no matching optimization "
	self subclassResponsibility
]

{ #category : #accessing }
PjSpecialMessageConversion >> defaultOrder [
	" provide a numereic order for multiple optimizations for a given selector - lowest first "
	^ 1
]

{ #category : #options }
PjSpecialMessageConversion >> handleReturn: aBlock [
	^ self astConverter handleReturn: aBlock
]

{ #category : #visiting }
PjSpecialMessageConversion >> inExpressionDo: aBlock [
	^ self astConverter inExpressionDo: aBlock
]

{ #category : #'initialize-release' }
PjSpecialMessageConversion >> initialize [
	super initialize.
	self order: self defaultOrder.
]

{ #category : #accessing }
PjSpecialMessageConversion >> messageConverter [
	^ messageConverter
]

{ #category : #accessing }
PjSpecialMessageConversion >> messageConverter: anObject [
	messageConverter := anObject
]

{ #category : #testing }
PjSpecialMessageConversion >> needsAllPaths [
	^self astConverter needsAllPaths
]

{ #category : #accessing }
PjSpecialMessageConversion >> newTemp [
	^self astConverter newTemp
]

{ #category : #accessing }
PjSpecialMessageConversion >> order [
	^ order
]

{ #category : #accessing }
PjSpecialMessageConversion >> order: aNumber [
	order := aNumber
]

{ #category : #accessing }
PjSpecialMessageConversion >> selector [
	self subclassResponsibility
]

{ #category : #options }
PjSpecialMessageConversion >> tempName [
	^ self astConverter tempName
]

{ #category : #options }
PjSpecialMessageConversion >> tempNameFree: tempName [
	^ self astConverter tempNameFree: tempName
]

{ #category : #comparing }
PjSpecialMessageConversion >> valuesToCompareForEquality [
	^{self order. self selector}
]

{ #category : #visiting }
PjSpecialMessageConversion >> visit: astNode [ 
	^ astNode acceptVisitor: self astConverter
]

{ #category : #visiting }
PjSpecialMessageConversion >> visitAllNodes: aRBBlockNode [
	^ self astConverter visitAllNodes: aRBBlockNode
]

{ #category : #visiting }
PjSpecialMessageConversion >> visitInlineBlock: aRBBlockNode [ 
	^ self astConverter visitInlineBlock: aRBBlockNode
]

{ #category : #visiting }
PjSpecialMessageConversion >> visitInlineLoopBlock: aRBBlockNode [
	^ self astConverter visitInlineLoopBlock: aRBBlockNode
]

{ #category : #'non-nil handling' }
PjSpecialMessageConversion >> withNonNil: aPjJavascriptAstNode do: aBlockClosure [
	^ self astConverter withNonNil: aPjJavascriptAstNode do: aBlockClosure
]

{ #category : #options }
PjSpecialMessageConversion >> withTemp: aBlockClosure [
	| tempName ast |
	tempName := self tempName.
	ast := aBlockClosure value: tempName.
	self tempNameFree: tempName.
	^ ast
]

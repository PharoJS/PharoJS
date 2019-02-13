"
I represent a block closure without any free variable.
"
Class {
	#name : #PjClosedBlockClosure,
	#superclass : #BlockClosure,
	#type : #variable,
	#instVars : [
		'originalBlock',
		'externalVariables'
	],
	#category : #'PharoJsTranspiler-Kernel'
}

{ #category : #'instance creation' }
PjClosedBlockClosure class >> outerContext: aContext startpc: startpc numArgs: numArgs copiedValues: aCollection originalBlock: aBlock [
	^(self outerContext: aContext startpc: startpc numArgs: numArgs copiedValues: aCollection)
		originalBlock: aBlock;
		externalVariables;
		yourself
]

{ #category : #visiting }
PjClosedBlockClosure >> acceptVisitor: aPjAstConverter [
	^ aPjAstConverter convertClosedBlock: self
]

{ #category : #public }
PjClosedBlockClosure >> asClosedBlock [
	^self
]

{ #category : #converting }
PjClosedBlockClosure >> convertToJsUsing: aPjTranspiler [ 
	aPjTranspiler convertClosedBlock: self
]

{ #category : #public }
PjClosedBlockClosure >> externalVariable: name fromContext: context [
	|value scope|
	scope := context sourceNode scope.
	value := scope lookupVar: name inContext: context.
	^[value ifNil: [ scope outerScopeLookupVar: name inContext: context ]] on: Error do: [nil].

]

{ #category : #public }
PjClosedBlockClosure >> externalVariable: name fromMethod: method [
	^ method instVarNamed: name
]

{ #category : #public }
PjClosedBlockClosure >> externalVariables [
	^ externalVariables ifNil: [
		externalVariables := self externalVariablesOf: self originalBlock]
]

{ #category : #testing }
PjClosedBlockClosure >> isClosed [
	^true
]

{ #category : #accessing }
PjClosedBlockClosure >> originalBlock [
	^ originalBlock
]

{ #category : #accessing }
PjClosedBlockClosure >> originalBlock: anObject [
	originalBlock := anObject
]

{ #category : #accessing }
PjClosedBlockClosure >> sourceNode [
	^ originalBlock sourceNode
]

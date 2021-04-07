Trait {
	#name : #PjTClosedBlockClosure,
	#instVars : [
		'externalVariables',
		'originalBlock'
	],
	#category : #'PharoJsTranspiler-Kernel'
}

{ #category : #'instance creation' }
PjTClosedBlockClosure classSide >> outerContext: aContext startpc: startpc numArgs: numArgs copiedValues: aCollection originalBlock: aBlock [
	^(self outerContext: aContext startpc: startpc numArgs: numArgs copiedValues: aCollection)
		originalBlock: aBlock;
		yourself
]

{ #category : #visiting }
PjTClosedBlockClosure >> acceptVisitor: aPjAstConverter [
	^ aPjAstConverter convertClosedBlock: self
]

{ #category : #public }
PjTClosedBlockClosure >> asClosedBlock [
	^self
]

{ #category : #converting }
PjTClosedBlockClosure >> convertToJsUsing: aPjTranspiler [ 
	aPjTranspiler convertClosedBlock: self
]

{ #category : #public }
PjTClosedBlockClosure >> externalVariable: name fromContext: context andScope: scope [

	| value |
	value := scope lookupVar: name inContext: context.
	^ [ 
	  value ifNil: [ scope outerScopeLookupVar: name inContext: context ] ]
		  on: Error
		  do: [ nil ]
]

{ #category : #public }
PjTClosedBlockClosure >> externalVariable: name fromMethod: method [
	^ method instVarNamed: name
]

{ #category : #public }
PjTClosedBlockClosure >> externalVariables [
	^ externalVariables
]

{ #category : #testing }
PjTClosedBlockClosure >> isClosed [
	^true
]

{ #category : #accessing }
PjTClosedBlockClosure >> originalBlock [
	^ originalBlock
]

{ #category : #accessing }
PjTClosedBlockClosure >> originalBlock: aBlock [
	originalBlock := aBlock.
	externalVariables := self externalVariablesOf: originalBlock
]

{ #category : #accessing }
PjTClosedBlockClosure >> sourceNode [
	^ originalBlock sourceNode
]

"
Trait for closed block closure handling
"
Trait {
	#name : #PjTClosedBlockClosure,
	#instVars : [
		'originalBlock',
		'externalVariablesDict'
	],
	#category : #'PharoJs-Base-Transpiler-Kernel'
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

{ #category : #accessing }
PjTClosedBlockClosure >> basicOriginalBlock: aBlock [
	originalBlock := aBlock.
	externalVariablesDict := self externalVariablesDictOf: originalBlock
]

{ #category : #converting }
PjTClosedBlockClosure >> convertToJsUsing: aPjTranspiler [ 
	aPjTranspiler convertClosedBlock: self
]

{ #category : #public }
PjTClosedBlockClosure >> externalValueForVariable: variable startingFrom: context scope: scope [

	^ variable readFromContext: context scope: scope closure: self
]

{ #category : #public }
PjTClosedBlockClosure >> externalVariable: name fromContext: context andScope: scope [

	| variable |
	variable := scope lookupVar: name declare: false.
	^self externalValueForVariable: variable startingFrom: context scope: scope.

]

{ #category : #public }
PjTClosedBlockClosure >> externalVariable: name fromMethod: method [
	^ method instVarNamed: name
]

{ #category : #public }
PjTClosedBlockClosure >> externalVariablesDict [
	^ externalVariablesDict
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
	externalVariablesDict := self externalVariablesDictOf: originalBlock
]

{ #category : #accessing }
PjTClosedBlockClosure >> sourceNode [
	^ originalBlock sourceNode
]

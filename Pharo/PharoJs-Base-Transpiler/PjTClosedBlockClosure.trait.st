"
Trait for closed block closure handling
"
Trait {
	#name : #PjTClosedBlockClosure,
	#instVars : [
		'externalVariables',
		'originalBlock'
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

{ #category : #converting }
PjTClosedBlockClosure >> convertToJsUsing: aPjTranspiler [ 
	aPjTranspiler convertClosedBlock: self
]

{ #category : #public }
PjTClosedBlockClosure >> externalValueForVariable: variable startingFrom: context scope: scope [

	"	scope = variable scope ifTrue: [ 
		^ variable readFromLocalContext: context ].
	^ self
		  externalValueForVariable: variable
		  startingFrom: (scope nextOuterScopeContextOf: context)
		  scope: scope outerScope"

	| definingContext definingScope |
	definingContext := scope
		                   lookupDefiningContextForVariable: variable
		                   startingFrom: context.
	definingScope := definingContext sourceNode scope.
	^ variable readFromContext: definingContext scope: definingScope
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

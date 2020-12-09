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
PjClosedBlockClosure >> enclosingScopeForContext: context [
	| sourceNode |
	sourceNode := context method sourceNodeForPC: context previousPcWithCorrectMapping.
	^sourceNode enclosingMethodOrBlockNode scope

]

{ #category : #public }
PjClosedBlockClosure >> externalVariable: name fromContext: context [
	|value scope |
	scope := self enclosingScopeForContext: context.
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

{ #category : #public }
PjClosedBlockClosure >> externalVariablesOf: aBlock [
	| context method variables tempValue scope |
	variables := Dictionary new.
	context := aBlock outerContext.
	scope := self enclosingScopeForContext: context. 
	scope allTempNames
		do: [ :name | 
			tempValue := self externalVariable: name fromContext: context.
			variables at: name put: tempValue ].
	method := aBlock home receiver.
	method class allInstVarNames
		do: [ :name | 
			variables
				at: name
				put: (self externalVariable: name fromMethod: method) ].
	^ variables
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

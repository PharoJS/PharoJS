Extension { #name : #BlockClosure }

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> arguments [
	^#()
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> asClosedBlock [

	^ self closedBlockClass
		  outerContext: self outerContext
		  startpc: self basicStartpc
		  numArgs: self numArgs
		  copiedValues: self copiedValuesForClosedBlock
		  originalBlock: self
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> asJsAstUsing: aConverter [
	^aConverter convertBlock: self
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> asValuedBlock [
	^PjValuedClosedBlockClosure newFrom: self
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> asValuedBlockWithArgs: args [
	^PjValuedClosedBlockClosure newFrom: self withArgs: args
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> basicStartpc [
	^startpc
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> closedBlockClass [
	^PjClosedBlockClosure
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> convertToJavascriptAstUsing: aPjAstConverter [
	^ aPjAstConverter visit: self
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> convertToJsUsing: aPjTranspiler [ 
	aPjTranspiler convertBlock: self
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> copiedValues [
	^(1 to: self numCopiedValues) collect: [: index | 
		self copiedValueAt: index].
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> copiedValuesForClosedBlock [
	^self copiedValues collect: [ : each | each copy ]
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> externalVariable: name fromContext: context andScope: scope [
	^ PjJavascriptTranspilationError new messageText: 'free temp variable: ',name
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> externalVariable: name fromMethod: method [
	^ PjJavascriptTranspilationError new messageText: 'free instance variable: ',name
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> externalVariables [
	^ self externalVariablesOf: self
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> externalVariablesOf: aBlock [

	| context method variables tempValue scope |
	variables := Dictionary new.
	context := aBlock outerContext.
	scope := context sourceNode scope.
	scope allTempNames do: [ :name | 
		tempValue := self externalVariable: name fromContext: context andScope: scope.
		variables at: name put: tempValue ].
	method := aBlock home receiver.
	method class allInstVarNames do: [ :name | 
		variables
			at: name
			put: (self externalVariable: name fromMethod: method) ].
	^ variables
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> firstAstNode [
	^self sourceNode statements first
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> isClosed [
	^ false
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> isFreeJavascriptValue [
	^ self isClosed
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> originalBlock [
	^ self
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure class >> outerContext: aContext startpc: startPcOrOuterCode numArgs: anInteger copiedValues: copiedValues [ 
	| newBlock |
	newBlock := self new: copiedValues size.
	newBlock
		outerContext: aContext;
		compiledBlock: startPcOrOuterCode;
		numArgs: anInteger.
	1 to: newBlock numCopiedValues do:
		[:i|
		newBlock at: i put: (copiedValues at: i)].
	^newBlock 
	
		
]

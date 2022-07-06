Extension { #name : #BlockClosure }

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> arguments [
	^#()
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> asClosedBlock [

	^ self closedBlockClass
		  startpc: self basicStartpc
		  numArgs: self numArgs
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
BlockClosure >> externalVariable: variable formContext: context [
	^ PjJavascriptTranspilationError new messageText: 'free temp variable: ', variable name
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
BlockClosure >> externalVariablesDict [
	^ self externalVariablesDictOf: self
]

{ #category : #'*PharoJs-Base-Transpiler' }
BlockClosure >> externalVariablesDictOf: aBlock [

	| context method variablesDict tempValue scope |
	variablesDict := Dictionary new.
	context := aBlock asContext.
	scope := context sourceNode scope.
"Experimental: Does not capture all external variables!!!!"
	scope copiedVars do: [ :variable | 		
		tempValue := self externalVariable: variable formContext: context.
		variablesDict at: variable name put: tempValue ].
	method := aBlock home receiver.
	method class allInstVarNames do: [ :name | 
		variablesDict
			at: name
			put: (self externalVariable: name fromMethod: method) ].
	^ variablesDict
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

"
I translate Smalltalk ASTs into PjAST (javascript ASTs)
"
Class {
	#name : #PjAstConverter,
	#superclass : #Object,
	#instVars : [
		'blockNestingLevel',
		'isReturnLegalInBlocks',
		'hasNonLocalReturns',
		'hasInBlockSelfReferences',
		'messageConverter',
		'expressionNestingLevel',
		'tempNumber',
		'tempMaxNumber',
		'classForConversion',
		'pushingReturnClass',
		'transpiler',
		'needSelfReturn',
		'extraTempVariablesToDeclare',
		'blockClosureAnalyser',
		'nonNilIdentifiers',
		'methodPrimitive',
		'currentConvertingMethod',
		'extraBindings',
		'loopNestingLevel'
	],
	#category : #'PharoJsTranspiler-Kernel'
}

{ #category : #accessing }
PjAstConverter class >> jsCodeGeneratorPragmaKeyword [
	"The argument of the pragma is a selector for class side message that generates javascript code that is used as the body of the method.
	The smalltalk code if any is simply ignored."
	^#jsGenerator:

]

{ #category : #accessing }
PjAstConverter class >> jsCodePragmaKeyword [
	"The argument of the pragma provides javascript code that is used as the body of the method.
	The smalltalk code if any is simply ignored."
	^#javascript:

]

{ #category : #accessing }
PjAstConverter class >> jsLiteralGeneratorPragmaKeyword [
	"The argument of the pragma is a selector for class side message that generates javascript code that is used as the body of the method.
	The smalltalk code if any is simply ignored."
	^#jsLiteralGenerator

]

{ #category : #conversions }
PjAstConverter >> addAllConversions: aCollection [
	messageConverter addAllConversions: aCollection
]

{ #category : #'initialize-release' }
PjAstConverter >> addAllMessageConversions: conversions [
	self messageConverter addAllConversions: conversions 
	
]

{ #category : #accessing }
PjAstConverter >> allowReturnsInBlocks [
	self isReturnLegalInBlocks: true
]

{ #category : #visiting }
PjAstConverter >> astForJsCode: jsCode [
	^ {(PjUnparsedStringNode
		string:
			(String lf
				join:
					((jsCode
						regex:
							'[^
	]*'
						matchesCollect: #yourself)
						reject: [ :each | each isEmpty or: [ each beginsWith: '//' ] ])))}
]

{ #category : #visiting }
PjAstConverter >> checkFree: aRBVariableNode [
	^ blockClosureAnalyser ifNotNil: [
		blockClosureAnalyser checkFree: aRBVariableNode]
]

{ #category : #visiting }
PjAstConverter >> checkSelfReturn: result [
	result canPropogateReturns ifFalse: [
		blockNestingLevel = 0 ifTrue: [ needSelfReturn := true ]].
	^ result
]

{ #category : #accessing }
PjAstConverter >> classForConversion [
	^ classForConversion
]

{ #category : #accessing }
PjAstConverter >> classForConversion: anObject [
	classForConversion := anObject
]

{ #category : #public }
PjAstConverter >> convertAst: ast withPrimitive: anInteger [
	methodPrimitive := anInteger.
	^self visit: ast
]

{ #category : #public }
PjAstConverter >> convertBlock: aBlockClosure [
	blockClosureAnalyser := PjBlockClosureAnalyser onBlock: aBlockClosure.
	[^ self visit: blockClosureAnalyser sourceNode
	] ensure: [blockClosureAnalyser := nil]
]

{ #category : #public }
PjAstConverter >> convertClosedBlock: block [
	| savedBlockClosureAnalyser |
	savedBlockClosureAnalyser := blockClosureAnalyser.
	blockClosureAnalyser := PjBlockClosureAnalyser onBlock: block.
	[^ blockClosureAnalyser closeAst: (self visit: blockClosureAnalyser sourceNode) with: self
	] ensure: [blockClosureAnalyser := savedBlockClosureAnalyser]
]

{ #category : #public }
PjAstConverter >> convertFirstStatementOfBlock: stAst [
	self reset.
	^ self visit: stAst
]

{ #category : #public }
PjAstConverter >> convertValuedBlock: block [
	| closedBlockAst closedBlockAstArgs|
	closedBlockAst := self convertClosedBlock: block.
	closedBlockAstArgs := block arguments collect: [: each | each asJsAstUsing: self].
	^PjApplyNode func: closedBlockAst args: closedBlockAstArgs
]

{ #category : #visiting }
PjAstConverter >> discoveredGlobalsPool: aClass [
	self transpiler ifNotNil: [ 
	transpiler discoveredGlobalsPool: aClass]
]

{ #category : #visiting }
PjAstConverter >> discoveredMessage: selector [
		self transpiler ifNil: [ ^ self ].
		transpiler discoveredMessage: selector
]

{ #category : #visiting }
PjAstConverter >> discoveredReferenceToClass: aClass [
	self transpiler ifNil: [ ^self ].
	self transpiler discoveredReferenceToClass: aClass
]

{ #category : #visiting }
PjAstConverter >> handleJsCodeGeneratorPragmaInMethodNode: aRBMethodNode [
	| jsGeneratorPragma generatorSelector jsCode |
	jsGeneratorPragma := aRBMethodNode
		pragmaNamed: self jsCodeGeneratorPragmaKeyword.
	generatorSelector := jsGeneratorPragma arguments first.
	jsCode := classForConversion instanceSide
		perform: generatorSelector value with: transpiler.
	^ self astForJsCode: jsCode
]

{ #category : #visiting }
PjAstConverter >> handleJsCodePragmaInMethodNode: aRBMethodNode [
	| jsCodePragma jsCode |
	jsCodePragma := aRBMethodNode pragmaNamed: self jsCodePragmaKeyword.
	jsCode := jsCodePragma arguments first value.
	^self astForJsCode: jsCode
]

{ #category : #'as yet unclassified' }
PjAstConverter >> handleJsLiteralGeneratorPragmaInMethodNode: aRBMethodNode [ 
	| jsCode forClass selector result |
	forClass := aRBMethodNode scope outerScope outerScope getClass.
	selector := aRBMethodNode selector.
	jsCode := String streamContents: [: s |
		s nextPutAll: 'return '.
		result := forClass isMeta ifTrue: [
				forClass instanceSide perform: selector
			] ifFalse: [
				forClass basicNew perform: selector
			].
		result isLiteralJavascriptValue ifFalse: [ PjJavascriptTranspilationError signal: forClass asString,'>>#',selector,' returns a value with no literal Javascript representation'].
		result printJsOn: s.
	].
	^ self astForJsCode: jsCode
]

{ #category : #visiting }
PjAstConverter >> handlePragmaInMethodNode: aRBMethodNode [
	| body |
	(aRBMethodNode hasPragmaNamed: self jsCodePragmaKeyword)
		ifTrue: [ ^self handleJsCodePragmaInMethodNode: aRBMethodNode ].
	(aRBMethodNode hasPragmaNamed: self jsCodeGeneratorPragmaKeyword)
		ifTrue: [ ^self handleJsCodeGeneratorPragmaInMethodNode: aRBMethodNode ].
	(aRBMethodNode hasPragmaNamed: self jsLiteralGeneratorPragmaKeyword)
		ifTrue: [ ^self handleJsLiteralGeneratorPragmaInMethodNode: aRBMethodNode ].
	pushingReturnClass := nil.	"PjReturnNode"
	needSelfReturn := false.
	(methodPrimitive ~= 0
		and: [ methodPrimitive ~= 256 and: [ aRBMethodNode statements isEmpty ] ])
		ifTrue: [ PjJavascriptTranspilationError
				signal: 'primitive method with no fallback code: ', aRBMethodNode selector ].
	body := self visitAllNodes: aRBMethodNode statements.
	(needSelfReturn
		and: [ body isEmpty or: [ body expressions last isReturnOrThrow not ] ])
		ifTrue: [ body addLast: (PjReturnNode expression: PjSelfNode new) ].
	self hasNonLocalReturns
		ifTrue: [ body := PjTryNode body: body ].
	^ body
]

{ #category : #visiting }
PjAstConverter >> handleReturn: aBlock [
	| savePushingReturnClass result |
	savePushingReturnClass := pushingReturnClass.
	pushingReturnClass := nil.
	[
		result := aBlock value
	] ensure: [
		pushingReturnClass := savePushingReturnClass.
	].
	self checkSelfReturn: PjSelfNode new. " flag to add a return, because the block didn't "
	^ result
]

{ #category : #accessing }
PjAstConverter >> hasInBlockSelfReferences [
	^hasInBlockSelfReferences
]

{ #category : #accessing }
PjAstConverter >> hasInBlockSelfReferences: aBoolean [
	hasInBlockSelfReferences := aBoolean
]

{ #category : #accessing }
PjAstConverter >> hasNonLocalReturns [
	^ hasNonLocalReturns
]

{ #category : #accessing }
PjAstConverter >> hasNonLocalReturns: anObject [
	hasNonLocalReturns := anObject
]

{ #category : #accessing }
PjAstConverter >> inExpressionDo: aBlock [
	| savePushing saveNeedSelfReturn |
	^ [
		expressionNestingLevel := expressionNestingLevel + 1.
		savePushing := pushingReturnClass.
		saveNeedSelfReturn := needSelfReturn.
		pushingReturnClass := nil.
		aBlock value
	] ensure: [
		needSelfReturn := saveNeedSelfReturn.
		pushingReturnClass := savePushing.
		expressionNestingLevel := expressionNestingLevel - 1
	]
]

{ #category : #'initialize-release' }
PjAstConverter >> initialize [
	super initialize.
	self messageConverter: self messageConverterClass new.
	blockNestingLevel := 0.
	loopNestingLevel := 0.
	expressionNestingLevel := 0.
	self resetExtraTempVariablesToDeclare.
	self allowReturnsInBlocks.
	extraBindings := Dictionary new.
	self reset.

]

{ #category : #testing }
PjAstConverter >> isInBlock [
	^blockNestingLevel > 0
]

{ #category : #testing }
PjAstConverter >> isInExpression [
	^ expressionNestingLevel > 0
]

{ #category : #accessing }
PjAstConverter >> isReturnLegalInBlocks [
	^isReturnLegalInBlocks
]

{ #category : #accessing }
PjAstConverter >> isReturnLegalInBlocks: aBoolean [
	isReturnLegalInBlocks := aBoolean
]

{ #category : #accessing }
PjAstConverter >> jsCodeGeneratorPragmaKeyword [
	^self class jsCodeGeneratorPragmaKeyword
]

{ #category : #accessing }
PjAstConverter >> jsCodePragmaKeyword [
	^self class jsCodePragmaKeyword
]

{ #category : #'as yet unclassified' }
PjAstConverter >> jsLiteralGeneratorPragmaKeyword [
	^ self class jsLiteralGeneratorPragmaKeyword
]

{ #category : #accessing }
PjAstConverter >> messageConverter [
	^ messageConverter
]

{ #category : #accessing }
PjAstConverter >> messageConverter: anObject [
	messageConverter := anObject.
	messageConverter astConverter: self.
]

{ #category : #'initialize-release' }
PjAstConverter >> messageConverterClass [
	^PjMessageConverter
]

{ #category : #accessing }
PjAstConverter >> needsAllPaths [
	^ self isInExpression or: [ pushingReturnClass notNil]
]

{ #category : #'temp vars' }
PjAstConverter >> newTemp [
	| tempName |
	tempName := self tempName.
	extraTempVariablesToDeclare add: tempName.
	^tempName
]

{ #category : #'temp vars' }
PjAstConverter >> newTemp: tempName [
	extraTempVariablesToDeclare add: tempName.
	^ tempName
]

{ #category : #'non-nil handling' }
PjAstConverter >> nonNilIdentifiers [
	^ nonNilIdentifiers ifNil: [ nonNilIdentifiers := Stack new ]
]

{ #category : #public }
PjAstConverter >> preventNonLocalReturns [
	self isReturnLegalInBlocks: false
]

{ #category : #conversions }
PjAstConverter >> removeAllConversions: aCollection [
	messageConverter removeAllConversions: aCollection
]

{ #category : #'initialize-release' }
PjAstConverter >> removeAllMessageConversions: conversions [
	self messageConverter removeAllConversions: conversions 
	
]

{ #category : #public }
PjAstConverter >> reset [
	self hasInBlockSelfReferences: false.
	self hasNonLocalReturns: false.
	pushingReturnClass := nil.
	tempNumber := 0.
	tempMaxNumber := 0

]

{ #category : #'initialize-release' }
PjAstConverter >> resetExtraTempVariablesToDeclare [
	extraTempVariablesToDeclare := Set new.
]

{ #category : #visiting }
PjAstConverter >> returnNodeWith: someNode [
	| result |
	result := someNode acceptVisitor: self.
	pushingReturnClass ifNil: [ ^ self checkSelfReturn: result ].
	result canPropogateReturns ifTrue: [ ^ result ].
	^ pushingReturnClass expression: result
]

{ #category : #public }
PjAstConverter >> setExtraBindings: aDictionary [
	extraBindings := aDictionary
]

{ #category : #visiting }
PjAstConverter >> signal: varType ifClosedBlockReferences: id [
	blockClosureAnalyser
		ifNotNil: [ PjJavascriptTranspilationError
				signal: 'reference to ', varType, ' in block: ' , id ].
	
]

{ #category : #accessing }
PjAstConverter >> tempMaxNumber [
	^ tempMaxNumber
]

{ #category : #accessing }
PjAstConverter >> tempMaxNumber: anObject [
	tempMaxNumber := anObject
]

{ #category : #'temp vars' }
PjAstConverter >> tempName [
	tempNumber := tempNumber + 1.
	tempNumber > self tempMaxNumber ifTrue: [ self tempMaxNumber: tempNumber ].
	^ PjStringGenerator tempNamePrefix, tempNumber asString
]

{ #category : #'temp vars' }
PjAstConverter >> tempNameFree: temp [
	temp ifNil: [ ^ self ].
	PjStringGenerator tempNamePrefix, tempNumber asString = temp ifFalse: [^ self].
	tempNumber := tempNumber - 1
]

{ #category : #'error handling' }
PjAstConverter >> transpilationError: aString [ 
	^ PjJavascriptTranspilationError signal: aString,(currentConvertingMethod ifNil: [
			''
		] ifNotNil: [
			' - found in ',currentConvertingMethod methodReference asString
		])
]

{ #category : #accessing }
PjAstConverter >> transpiler [
	^ transpiler
]

{ #category : #accessing }
PjAstConverter >> transpiler: aPjTranspiler [
	transpiler := aPjTranspiler
]

{ #category : #visiting }
PjAstConverter >> visit: aRBAstNode [ 
	^aRBAstNode acceptVisitor: self
]

{ #category : #visiting }
PjAstConverter >> visitAllNodes: someRBNodes [
	| expressions lastExpression savedPushing |
	someRBNodes ifEmpty: [ ^ self checkSelfReturn: (PjSequenceNode expressions: OrderedCollection new)].
	expressions := [
			savedPushing := pushingReturnClass.
			pushingReturnClass := nil.
			someRBNodes allButLast collect: [ :each |
				self visit: each ]
		] ensure: [
			pushingReturnClass := savedPushing
		].
	lastExpression := self returnNodeWith: someRBNodes last.
	expressions addLast: lastExpression.
	^ PjSequenceNode expressions: expressions

]

{ #category : #visiting }
PjAstConverter >> visitArgumentNode: aRBArgumentNode [
	(self checkFree: aRBArgumentNode) ifNotNil: [ : result | ^ result].
	^PjArgumentNode identifier: aRBArgumentNode name
]

{ #category : #visiting }
PjAstConverter >> visitArrayNode: aRBArrayNode [
	^ self inExpressionDo: [PjArrayNode expressions: (aRBArrayNode statements collect: [: each | self visit: each ])]
]

{ #category : #visiting }
PjAstConverter >> visitAssignmentNode: aRBAssignmentNode [ 
	^PjAssignNode 
		target:  (aRBAssignmentNode variable acceptVisitor: self) 
		expression: (self inExpressionDo: [aRBAssignmentNode value acceptVisitor: self]).

]

{ #category : #visiting }
PjAstConverter >> visitBlockNode: aRBBlockNode [
	| expressions savedExpressionNestingLevel savePushing savedExtraTempVariablesToDeclare extaTempVars |
	[
		savedExtraTempVariablesToDeclare := extraTempVariablesToDeclare.
		self resetExtraTempVariablesToDeclare.
		blockNestingLevel := blockNestingLevel + 1.
		savedExpressionNestingLevel := expressionNestingLevel.
		expressionNestingLevel := 0.
		savePushing := pushingReturnClass.
		pushingReturnClass := PjReturnNode.
		expressions := self visitAllNodes: (aRBBlockNode statements ifEmpty: [ OrderedCollection with: RBLiteralValueNode new ])
	] ensure: [
		extaTempVars := extraTempVariablesToDeclare.
		extraTempVariablesToDeclare := savedExtraTempVariablesToDeclare.
		pushingReturnClass := savePushing.
		expressionNestingLevel := savedExpressionNestingLevel.
		blockNestingLevel := blockNestingLevel - 1
	].
	^ PjBlockNode
		parameters: aRBBlockNode argumentNames
		locals: aRBBlockNode temporaryNames, extaTempVars asArray
		body: expressions
]

{ #category : #visiting }
PjAstConverter >> visitCascadeNode: aRBCascadeNode [ 
	| expressions receiver |
	receiver := aRBCascadeNode receiver.
	(receiver isSelf or: [ receiver isSuper ]) ifFalse: [
		receiver := RBTemporaryNode named: self newTemp
	].
	expressions := aRBCascadeNode messages collect: [ : each | 
		self visitMessageNode: (RBMessageNode receiver: receiver selector: each selector arguments: each arguments) isNonNil: true
	].
	receiver = aRBCascadeNode receiver ifFalse: [
		expressions addFirst: (PjAssignNode 
				target: (self visit: receiver)
				expression: (PjApplyNode
						func: (PjFieldNode
								target: (self visit: aRBCascadeNode receiver)
								selectorNode: nil isNonNil: false)
						args: nil))].
	^PjSequenceNode expressions: expressions.
]

{ #category : #visiting }
PjAstConverter >> visitClassOrPoolVariable: aRBGlobalNode id: id [
	| variableClass |
	variableClass := aRBGlobalNode binding scope getClass instanceSide.
	(variableClass instanceSide allClassVarNames includes: id)
		ifTrue: [ self signal: 'class variable' ifClosedBlockReferences: id.
			[ variableClass isNil
				or: [ variableClass classVarNames includes: id ] ]
				whileFalse: [ variableClass := variableClass superclass ].
			^ (PjClassVariableNode identifier: id)
						poolReference: variableClass;
						myClass: self classForConversion;
						yourself
				 ].
	(variableClass instanceSide sharedPoolOfVarNamedRecursive: id)
		ifNotNil: [ :pool | 
			pool isJavascriptGlobalsPool
				ifTrue: [ self discoveredGlobalsPool: pool.
					^ PjGlobalNode identifier: id ].
			self signal: 'pool' ifClosedBlockReferences: id.
			^ (PjPoolVariableNode identifier: id)
					poolReference: pool;
					myClass: self classForConversion;
					yourself ].
	PjJavascriptTranspilationError signal: 'pool or class variable isn''t: ' , id
]

{ #category : #visiting }
PjAstConverter >> visitGlobalNode: aRBGlobalNode [
	| global id |
	id := aRBGlobalNode name.
	global := Smalltalk
		at: id
		ifAbsent: [ ^ self visitClassOrPoolVariable: aRBGlobalNode id: id ].
	global isClass
		ifFalse: [ self signal: 'global' ifClosedBlockReferences: id.
			^ PjGlobalNode identifier: id ].
	self discoveredReferenceToClass: global.
	^ PjClassNode identifier: global nameToUseForJsConversion
]

{ #category : #visiting }
PjAstConverter >> visitInlineBlock: aRBProgramNode [
	| statements variable |
	aRBProgramNode isBlock ifFalse: [
		^ self returnNodeWith: aRBProgramNode ].
	statements := (aRBProgramNode statements ifEmpty: [RBLiteralValueNode new]
			) copy asOrderedCollection.
	aRBProgramNode temporaryNames do: [ : each |
		extraTempVariablesToDeclare add: each.
		loopNestingLevel >0 ifTrue: [
			variable := RBTemporaryNode named: each.
			statements addFirst: (RBAssignmentNode variable: variable value: RBLiteralValueNode new).
	]].
	^ (self visitAllNodes: statements) asSimpleNode.

]

{ #category : #visiting }
PjAstConverter >> visitInlineLoopBlock: aRBProgramNode [
	loopNestingLevel := loopNestingLevel + 1.
	[
		^ self visitInlineBlock: aRBProgramNode
	] ensure: [ loopNestingLevel := loopNestingLevel - 1 ]
]

{ #category : #visiting }
PjAstConverter >> visitInstanceVariableNode: aRBInstanceVariableNode [
	(self checkFree: aRBInstanceVariableNode) ifNotNil: [ : result | ^ result].
	^PjFieldNode target: (self visitSelfNode: nil) selectorNode: (PjInstanceVariableNode identifier: aRBInstanceVariableNode name) isNonNil: true
]

{ #category : #visiting }
PjAstConverter >> visitLiteralArrayNode: aRBLiteralArrayNode [ 
	^ PjArrayNode expressions: (aRBLiteralArrayNode contents collect: [: each | each acceptVisitor: self])
]

{ #category : #visiting }
PjAstConverter >> visitLiteralNode: aRBLiteralValueNode [ 
	^ aRBLiteralValueNode value ifNil: [
			PjNilNode new
		] ifNotNil: [ : nonNil |
			PjLiteralValueNode value: nonNil
		]
]

{ #category : #visiting }
PjAstConverter >> visitMessageNode: aRBMessageNode [ 
	^ self visitMessageNode: aRBMessageNode isNonNil: false
]

{ #category : #visiting }
PjAstConverter >> visitMessageNode: aRBMessageNode isNonNil: isNonNil [
	| target savedPushingReturnClass |
	(self messageConverter
		convert: aRBMessageNode selector
		receiver: aRBMessageNode receiver
		args: aRBMessageNode arguments) ifNotNil: [ : ast | ^ast ].
	self discoveredMessage: aRBMessageNode selector.
	[
		savedPushingReturnClass := pushingReturnClass.
		pushingReturnClass := nil.
		target := self visit: aRBMessageNode receiver.
		^PjApplyNode
			func: (PjFieldNode
				target: target
				selectorNode: (PjMessageSelectorNode identifier: aRBMessageNode selector)
				isNonNil: (isNonNil or: [target isNonNilNode or: [aRBMessageNode selector beginsWith: PjTranspiler jsNativePrefix]]))
			args:  (aRBMessageNode arguments collect: [ : each | self inExpressionDo: [each acceptVisitor: self] ])
	] ensure: [
		pushingReturnClass := savedPushingReturnClass ]
]

{ #category : #visiting }
PjAstConverter >> visitMethodNode: aRBMethodNode [
	| body extraTempVars |
	[
		currentConvertingMethod := aRBMethodNode compiledMethod.
		self resetExtraTempVariablesToDeclare.
		self reset.
		body := self handlePragmaInMethodNode: aRBMethodNode.
	] ensure:[
		extraTempVars := extraTempVariablesToDeclare.
		self resetExtraTempVariablesToDeclare.
		currentConvertingMethod := nil.
	].
	^ (PjMethodNode
		parameters: aRBMethodNode argumentNames
		locals: aRBMethodNode temporaryNames, extraTempVars asArray
		body: body
		methodName: aRBMethodNode selector
		needsSelf: self hasInBlockSelfReferences
		isClassMethod:
		(classForConversion
				ifNil: [ false ]
				ifNotNil: [ classForConversion isClassSide ]))
		myClass: classForConversion;
		yourself
]

{ #category : #visiting }
PjAstConverter >> visitReturnNode: aRBReturnNode [ 
	| savedPushing |
	savedPushing := pushingReturnClass.
	(self isInBlock or: [self isInExpression]) ifTrue: [
		self isReturnLegalInBlocks ifFalse: [
			self error: 'Returns in closed blocks are illegal.' ].
		pushingReturnClass := PjNonLocalReturnNode.
		self hasNonLocalReturns: true
	] ifFalse: [
		pushingReturnClass := PjReturnNode].
	[^self returnNodeWith: aRBReturnNode value
	] ensure: [
		pushingReturnClass := savedPushing]
]

{ #category : #visiting }
PjAstConverter >> visitSelfNode: aRBSelfNode [ 
	| inBlock |
	blockClosureAnalyser ifNotNil: [
		PjJavascriptTranspilationError signal: 'reference to self in block'
	].
	inBlock := self isInBlock.
	inBlock ifTrue: [ self hasInBlockSelfReferences: true ].
	^(PjSelfNode inBlock: inBlock) myClass: self classForConversion
]

{ #category : #visiting }
PjAstConverter >> visitSuperNode: aRBSuperNode [
	| inBlock |
	blockClosureAnalyser ifNotNil: [
		PjJavascriptTranspilationError signal: 'reference to super in block'
	].
	inBlock := self isInBlock.
	inBlock ifTrue: [ self hasInBlockSelfReferences: true ].
	^(PjSuperNode inBlock: inBlock) myClass: self classForConversion

]

{ #category : #visiting }
PjAstConverter >> visitTemporaryNode: aRBTemporaryNode [
	(self checkFree: aRBTemporaryNode) ifNotNil: [ : result | ^ result].
	^PjTempVariableNode identifier: aRBTemporaryNode name
]

{ #category : #visiting }
PjAstConverter >> visitThisContextNode: aRBThisContextNode [
	^ self transpilationError: 'thisContext not supported'
]

{ #category : #visiting }
PjAstConverter >> visitVariableNode: aRBVariableNode [
	| id |
	id := aRBVariableNode name.
	extraBindings at: id ifPresent: [: value |
		(value isKindOf: PjProxy) ifTrue: [ ^ PjGlobalNode identifier: id ]].
	self transpilationError: 'undefined variable "' , aRBVariableNode name , '"'.

]

{ #category : #'non-nil handling' }
PjAstConverter >> withNonNil: aPjJavascriptAstNode do: aBlockClosure [ 
	| result |
	self nonNilIdentifiers push: aPjJavascriptAstNode.
	result := aBlockClosure value.
	self nonNilIdentifiers pop.
	^ result
]

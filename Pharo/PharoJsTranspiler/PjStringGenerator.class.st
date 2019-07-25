"
I am a visitor to convert a Javascript AST into a string.

Includes $asNil$ optimization for field references in cases such as self, literals and ifNotNil. Maybe this should be extracted to another object. 

One of the challenges is to produce minimal parentheses based on the crazy numer of operator presedense rules for Javascript:

Precedence	Operator type	Associativity
19	Grouping		( … )
18	Member Access	left-to-right	. [] new
17	Function Call 	left-to-right	… ( … )
16	Postfix Incr/decr		…++	…--
15	Logical NOT	right-to-left	! …
	Bitwise NOT	right-to-left	~ …
	Unary Plus	right-to-left	+ …
	Unary Negation	right-to-left	- …
	Prefix Incr/decr	right-to-left	++ …	-- …
	typeof	right-to-left	typeof …
	void		right-to-left	void …
	delete	right-to-left	delete …
14	Exponentiation	right-to-left	… ** …
	Multiplication	left-to-right	… * …
	Division	left-to-right	… / …
	Remainder	left-to-right	… % …
13	Addition	left-to-right	… + …
	Subtraction	left-to-right	… - …
12	Bitwise Left Shift	left-to-right	… << …
	Bitwise Right Shift	left-to-right	… >> …
	Bitwise Unsigned Right Shift	left-to-right	… >>> …
11	Less Than	left-to-right	… < …
	Less Than Or Equal	left-to-right	… <= …
	Greater Than	left-to-right	… > …
	Greater Than Or Equal	left-to-right	… >= …
	in	left-to-right	… in …
	instanceof	left-to-right	… instanceof …
10	Equality	left-to-right	… == …
	Inequality	left-to-right	… != …
	Strict Equality	left-to-right	… === …
	Strict Inequality	left-to-right	… !== …
9	Bitwise AND	left-to-right	… & …
8	Bitwise XOR	left-to-right	… ^ …
7	Bitwise OR	left-to-right	… | …
6	Logical AND	left-to-right	… && …
5	Logical OR	left-to-right	… || …
4	Conditional	right-to-left	… ? … : …
3	Assignment	right-to-left	… = … 
	Op assign	right-to-left	+=	-=	**= 							*=	/=	%=	<<=
							>>=	>>>=	&=	^=	|=
2	yield	right-to-left	yield …
	yield*	right-to-left	yield* …
1	Spread	n/a	... …
0	Comma / Sequence	left-to-right	… , …

"
Class {
	#name : #PjStringGenerator,
	#superclass : #Object,
	#traits : 'PjTStreamWriter',
	#classTraits : 'PjTStreamWriter classTrait',
	#instVars : [
		'currentPrecedenceLevel',
		'jsStream',
		'wroteCloseBrace',
		'currentClass',
		'currentlyDoingAssignment'
	],
	#classVars : [
		'AssignmentPrecedence',
		'ConditionalPrecedence',
		'EqualityPrecedence',
		'ExpressionPrecedence',
		'FunctionCallPrecedence',
		'FunctionDefnPrecedence',
		'GroupingPrecedence',
		'JsReservedWordsForInstanceVariables',
		'JsReservedWordsForVariables',
		'MemberAccessPrecedence',
		'OperatorPrecedencesDict',
		'StatementPrecedence'
	],
	#category : #'PharoJsTranspiler-Kernel'
}

{ #category : #accessing }
PjStringGenerator class >> JsReservedWordsForInstanceVariables [
	^ JsReservedWordsForInstanceVariables
]

{ #category : #printing }
PjStringGenerator class >> asString: aPjAST [
	^ self new asString: aPjAST
]

{ #category : #'Javascript names' }
PjStringGenerator class >> classVariablesHolderName [
	^ 'prototype'
]

{ #category : #'class initialization' }
PjStringGenerator class >> initialize [
	FunctionDefnPrecedence := 3.
	StatementPrecedence := -1.
	ExpressionPrecedence := 0.
	AssignmentPrecedence := 3.
	ConditionalPrecedence := 4.
	EqualityPrecedence := 10.
	FunctionCallPrecedence := 17.
	MemberAccessPrecedence := 18.
	GroupingPrecedence := 19.
	OperatorPrecedencesDict := {
		#! -> 15.
		#negate -> 15.
		#typeof -> 15.
		#* -> 14.
		#/ -> 14.
		#% -> 14.
		#- -> 13.
		#+ -> 13.
		#< -> 11.
		#<= -> 11.
		#>= -> 11.
		#> -> 11.
		#== -> EqualityPrecedence.
		#!= -> EqualityPrecedence.
		#=== -> EqualityPrecedence.
		#!== -> EqualityPrecedence.
		#& -> 9.
		#'^' -> 8.
		#| -> 7.
		#&& -> 6.
		#|| -> 5.
		#? -> ConditionalPrecedence.
		#= -> AssignmentPrecedence.
	} as: IdentityDictionary.
	JsReservedWordsForVariables := Set newFrom:
		#(abstract arguments boolean break byte case catch char class const continue debugger default delete do double else enum eval export extends false final finally float for function goto if implements import in instanceof int interface let long native new null package private protected public return short static super switch synchronized this throw throws transient true try typeof var void volatile while with yield).
	JsReservedWordsForInstanceVariables := Set newFrom: #(constructor prototype)
]

{ #category : #accessing }
PjStringGenerator class >> memberAccessPrecedence [
	^MemberAccessPrecedence 
]

{ #category : #'Javascript names' }
PjStringGenerator class >> nilInJavascript [
	^ nil asJSON
]

{ #category : #'Javascript names' }
PjStringGenerator class >> nilTestFunctionName [
	^ self transpilerClass coreClass nilTestFunctionName
]

{ #category : #'Javascript names' }
PjStringGenerator class >> nonLocalReturnVariableName [
	^ '$_err_$'
]

{ #category : #'Javascript names' }
PjStringGenerator class >> selfName [
	^ '$_self_$'
]

{ #category : #'Javascript names' }
PjStringGenerator class >> tempNamePrefix [
	^ '$'
]

{ #category : #'Javascript names' }
PjStringGenerator class >> transpilerClass [
	^ PjTranspiler
]

{ #category : #public }
PjStringGenerator >> asString: aPjAST [
	^ String streamContents: [ : aStream | self asString: aPjAST on: aStream ]
]

{ #category : #public }
PjStringGenerator >> asString: aPjAST on: aStream [
	jsStream := aStream.
	currentPrecedenceLevel := -1.
	currentlyDoingAssignment := false.
	aPjAST acceptVisitor: self.

]

{ #category : #precedence }
PjStringGenerator >> atPrecedence: precedence do: aBlock [
	| savedPrecedence |
	currentPrecedenceLevel > precedence ifTrue: [ self writeNonBrace: $( ].
	savedPrecedence := currentPrecedenceLevel.
	currentPrecedenceLevel := precedence.
	[
		aBlock value
	] ensure: [
		currentPrecedenceLevel := savedPrecedence.
		currentPrecedenceLevel > precedence ifTrue: [ self writeNonBrace: $) ]
	]
]

{ #category : #accessing }
PjStringGenerator >> currentClass [
	^ currentClass
]

{ #category : #accessing }
PjStringGenerator >> currentClass: anObject [
	currentClass := anObject
]

{ #category : #precedence }
PjStringGenerator >> isAtStatementPrecedence [
	^ currentPrecedenceLevel = StatementPrecedence
]

{ #category : #accessing }
PjStringGenerator >> jsStream [
	^jsStream
]

{ #category : #writing }
PjStringGenerator >> maybeWriteSemicolon [
	wroteCloseBrace ifFalse: [ ^ self writeNonBrace: $; ]
]

{ #category : #accessing }
PjStringGenerator >> nilTestFunctionName [
	^self class nilTestFunctionName
]

{ #category : #precedence }
PjStringGenerator >> nonLocalReturnVariableName [
	^ self class nonLocalReturnVariableName
]

{ #category : #'as yet unclassified' }
PjStringGenerator >> selectorsPrefix [
	^PjTranspiler pharoJsSelectorPrefix
]

{ #category : #visiting }
PjStringGenerator >> visit: jsAstNode [ 
	^jsAstNode acceptVisitor: self
]

{ #category : #visiting }
PjStringGenerator >> visitApplyNode: aPjApplyNode [ 
	| args func |
	args := aPjApplyNode args.
	func := aPjApplyNode func.
	self atPrecedence: FunctionCallPrecedence do: [
		self visit: func.
		args ifNotNil: [
			(func isSuperSend ) ifTrue: [
				args := { PjSelfNode new inBlock: func target inBlock }, args.
				self nextPutAll: '.call'
			].
			self atPrecedence: ExpressionPrecedence  do: [
				args do: [: arg |
					arg acceptVisitor: self
				] separatedBy: [ self nextPut: $,
			]].
	]]
]

{ #category : #visiting }
PjStringGenerator >> visitArgumentNode: aPjTempVariableNode [ 
	self writeVariable: aPjTempVariableNode identifier escapingIfIn: JsReservedWordsForVariables
]

{ #category : #visiting }
PjStringGenerator >> visitArrayNode: aPjArrayNode [ 
	self writeNonBrace: $[.
	aPjArrayNode expressions do: [: expr |
		expr acceptVisitor: self
	] separatedBy: [
		self nextPut: $,
	].
	self writeNonBrace: $]
]

{ #category : #visiting }
PjStringGenerator >> visitAssignNode: aPjAssignNode [
	| saveDoingAssignment |
	(aPjAssignNode target isNonlocalClassOrPoolVariableReference: self currentClass) ifTrue: [
		^ 	self atPrecedence: FunctionCallPrecedence do: [
				saveDoingAssignment := currentlyDoingAssignment.
				currentlyDoingAssignment := true.
				self visit: aPjAssignNode target.
				currentlyDoingAssignment := saveDoingAssignment.
				self
					nextPut: $_;
					nextPut: $(;
					visit: aPjAssignNode expression;
					writeNonBrace: $)
		]
	].
	self atPrecedence: AssignmentPrecedence do: [
		self
			visit: aPjAssignNode target;
			nextPut: $=;
			visit: aPjAssignNode expression.
			wroteCloseBrace := false
	]
]

{ #category : #visiting }
PjStringGenerator >> visitBinaryNode: aPjABinaryNode [
	self atPrecedence: (OperatorPrecedencesDict at: aPjABinaryNode operator) do: [
		self
			visit: aPjABinaryNode left;
			nextPutAll: aPjABinaryNode operator;
			visit: aPjABinaryNode right
	]
]

{ #category : #visiting }
PjStringGenerator >> visitBlockNode: aPjMethodNode [
	currentPrecedenceLevel = StatementPrecedence ifFalse: [
		self visitFunctionNode: aPjMethodNode.
		wroteCloseBrace := false.
		^ self].
	self atPrecedence: FunctionDefnPrecedence + 1 do: [ 
		self visitFunctionNode: aPjMethodNode.
		wroteCloseBrace := false]
]

{ #category : #visiting }
PjStringGenerator >> visitClassNode: aPjClassNode [
	self nextPutAll: aPjClassNode identifier
]

{ #category : #visiting }
PjStringGenerator >> visitClassVariableNode: aPjClassVariableNode [
	self visitClassVariableNode: aPjClassVariableNode with: ''
]

{ #category : #visiting }
PjStringGenerator >> visitClassVariableNode: aPjClassVariableNode with: accessString [
	(self currentClass isNotNil and: [self currentClass isClassSide]) ifTrue: [
		self nextPut: $.; nextPutAll: PjStringGenerator classVariablesHolderName
	].
	self
		writeNonBrace: $.;
		writeVariable: aPjClassVariableNode identifier escapingIfIn: JsReservedWordsForInstanceVariables .
	currentlyDoingAssignment ifFalse: [self nextPutAll: accessString]
]

{ #category : #visiting }
PjStringGenerator >> visitFieldNode: aPjFieldNode [
	| target isLiteral isNonNil |
	target := aPjFieldNode target.
	isLiteral := target isLiteralNode and: [ target value isInteger ].
	isNonNil := isLiteral or: [ aPjFieldNode isNonNil ].
	self
		atPrecedence: MemberAccessPrecedence do: [
			isNonNil ifTrue: [
				isLiteral ifTrue: [
					self
						nextPut: $(;
						visit: aPjFieldNode target;
						writeNonBrace: $)
				] ifFalse: [
					self visit: aPjFieldNode target
			]] ifFalse: [
				self
					nextPutAll: self nilTestFunctionName;
					atPrecedence: FunctionCallPrecedence do: [
						self visit: aPjFieldNode target
			]].
			aPjFieldNode selectorNode ifNotNil: [self visitFieldNodeWithId: aPjFieldNode selectorNode]
		]
]

{ #category : #visiting }
PjStringGenerator >> visitFieldNodeWithId: fieldId [
	fieldId isLiteralSelector ifTrue: [ ^ self visit: fieldId ].
	(fieldId isLiteralNode
		and: [ fieldId value isString
			and: [ fieldId value
				allSatisfy: [ :c | c isAlphaNumeric or: [ c = $$ | (c = $_) ] ] ] ])
		ifTrue: [
			^ self
				writeNonBrace: $.;
				nextPutAll: fieldId value].
	self
		nextPut: $[;
		visit: fieldId;
		writeNonBrace: $]
]

{ #category : #visiting }
PjStringGenerator >> visitFunctionNode: aPjFunctionNode [
	self visitFunctionNode: aPjFunctionNode includeName: false
]

{ #category : #visiting }
PjStringGenerator >> visitFunctionNode: aPjFunctionNode includeName: aBoolean [
	self atPrecedence: FunctionDefnPrecedence do: [
		self writeFunctionHeader: aPjFunctionNode includeName: aBoolean.
		self writeFunctionBody: aPjFunctionNode
	]
]

{ #category : #visiting }
PjStringGenerator >> visitGlobalNode: aPjGlobalNode [
	self nextPutAll: aPjGlobalNode identifier
]

{ #category : #visiting }
PjStringGenerator >> visitInstanceVariableNode: aPjTempVariableNode [
	self
		writeNonBrace: $.;
		writeVariable: aPjTempVariableNode identifier escapingIfIn: JsReservedWordsForInstanceVariables
]

{ #category : #visiting }
PjStringGenerator >> visitLiteralValueNode: aPjALiteral [
	self print: aPjALiteral value
]

{ #category : #visiting }
PjStringGenerator >> visitMessageSelectorNode: aPjMessageSelectorNode [
	self writeNonBrace: $..
	self writeJsSelector: aPjMessageSelectorNode identifier onStream: self jsStream
]

{ #category : #visiting }
PjStringGenerator >> visitMethodNode: aPjMethodNode [
	| savedClass |
	savedClass := currentClass.
	currentClass := aPjMethodNode myClass.
	[
		self visitFunctionNode: aPjMethodNode includeName: true
	] ensure: [ currentClass := savedClass ]
]

{ #category : #visiting }
PjStringGenerator >> visitNilNode: aPjIfNilIfNotNilNode [ 
	self nextPutAll: self class nilInJavascript
]

{ #category : #visiting }
PjStringGenerator >> visitNonLocalReturnNode: aPjNonLocalReturnNode [
	self isAtStatementPrecedence ifTrue: [
		self nextPutAll: 'throw '
	] ifFalse: [
		self nextPutAll: PjCore throwFunctionName; nextPut: $( ].
	self
		nextPutAll: self class nonLocalReturnVariableName;
		writeNonBrace: $=;
		visit: aPjNonLocalReturnNode expression.
	self isAtStatementPrecedence ifFalse: [ self nextPut: $)]

]

{ #category : #visiting }
PjStringGenerator >> visitObjectNode: aPjObjectNode [
	| dictionary |
	dictionary := aPjObjectNode dictionary.
	self nextPut: ${.
	dictionary keys asSortedCollection do: [: key |
		(key allSatisfy: [: each | each isAlphaNumeric]) ifTrue: [
			self nextPutAll: key
		] ifFalse: [
			self nextPut: $";nextPutAll: key;nextPut: $"
		].
		self nextPut: $:.
		(dictionary at: key) acceptVisitor: self
	] separatedBy: [
		self nextPut: $,
	].
	self writeNonBrace: $} " even though this is a brace, it isn't an end-of-statement brace "
]

{ #category : #visiting }
PjStringGenerator >> visitPoolVariableNode: aPjClassVariableNode [
	self visitClassVariableNode: aPjClassVariableNode with: '$()'
]

{ #category : #visiting }
PjStringGenerator >> visitReturnNode: aPjAReturn [
	self isAtStatementPrecedence ifFalse: [
		self error: 'PjAReturn not at statement level'
	].
	self
		nextPutAll: 'return ';
		atPrecedence: ExpressionPrecedence  do: [self visit: aPjAReturn expression].
	wroteCloseBrace := false
]

{ #category : #visiting }
PjStringGenerator >> visitSelfNode: aPjASelf [
	aPjASelf inBlock ifTrue: [ ^ self nextPutAll: self class selfName ].
	self nextPutAll: 'this'
]

{ #category : #visiting }
PjStringGenerator >> visitSequenceNode: aPjSequenceNode [
	| bracket |
	bracket := aPjSequenceNode expressions size ~= 1.
	bracket ifTrue: [self writeNonBrace: (self isAtStatementPrecedence ifTrue: ${ ifFalse: $()].
	aPjSequenceNode expressions do: [: expr |
		wroteCloseBrace := false..
		expr acceptVisitor: self
	] separatedBy: [
		self isAtStatementPrecedence ifTrue: [
			self maybeWriteSemicolon
		] ifFalse: [
			self nextPut: $,
	]].
	bracket ifTrue: [
		self isAtStatementPrecedence ifTrue: [
			self writeCloseBrace
		] ifFalse: [
			self writeNonBrace: $)
	]]
]

{ #category : #visiting }
PjStringGenerator >> visitSuperNode: aPjSuperNode [
	| class |
	class := aPjSuperNode myClass superclass.
	class isMeta
		ifTrue: [ self nextPutAll: class instanceSide nameToUseForJsConversion ]
		ifFalse: [ self
				nextPutAll: class nameToUseForJsConversion;
				nextPutAll: '.prototype' ]
]

{ #category : #visiting }
PjStringGenerator >> visitTempVariableNode: aPjTempVariableNode [ 
	self writeVariable: aPjTempVariableNode identifier escapingIfIn: JsReservedWordsForVariables
]

{ #category : #visiting }
PjStringGenerator >> visitTryNode: aPjATry [ 
	self atPrecedence: StatementPrecedence do:  [
		self nextPutAll: 'var ';
			nextPutAll: self nonLocalReturnVariableName;
			nextPutAll: '={};try{'.
		self
			writeBodyStatements: aPjATry;
			nextPutAll: '}catch(e){if(e===';
			nextPutAll: self nonLocalReturnVariableName;
			nextPutAll: ')return e;throw e';
			writeCloseBrace
	]
]

{ #category : #visiting }
PjStringGenerator >> visitUnaryNode: aPjUnaryNode [ 
	self atPrecedence: (OperatorPrecedencesDict at: aPjUnaryNode operator) do: [
		self
			nextPutAll: aPjUnaryNode operator;
			visit: aPjUnaryNode expression
	]
]

{ #category : #visiting }
PjStringGenerator >> visitUnparsedStringNode: aPjUnparsedStringNode [
	self nextPutAll: aPjUnparsedStringNode string
]

{ #category : #visiting }
PjStringGenerator >> visitVariableNode: aPjVariableNode [
	self nextPutAll: aPjVariableNode identifier
]

{ #category : #writing }
PjStringGenerator >> writeBodyStatements: aBodyContainingNode [
	currentPrecedenceLevel := StatementPrecedence.
	wroteCloseBrace := false.
	aBodyContainingNode body
		do: [ :each | self visit: each ]
		separatedBy: [ self maybeWriteSemicolon ]
]

{ #category : #writing }
PjStringGenerator >> writeCloseBrace [
	self nextPut: $}.
	wroteCloseBrace := true
]

{ #category : #writing }
PjStringGenerator >> writeFunctionBody: aPjFunctionNode [
	self
		nextPut: ${;
		writeFunctionLocals: aPjFunctionNode;
		writeBodyStatements: aPjFunctionNode;
		writeCloseBrace
]

{ #category : #writing }
PjStringGenerator >> writeFunctionHeader: aPjFunctionNode includeName: aBoolean [
	self
		nextPutAll: 'function'.
	aBoolean ifTrue: [
		self
			nextPut: $ ;
			writeJsSelector: aPjFunctionNode methodName onStream: self
	].
	self
		nextPut: $(;
		writeSafeNames: aPjFunctionNode parameters;
		nextPut: $).

]

{ #category : #writing }
PjStringGenerator >> writeFunctionLocals: aPjFunctionNode [
		aPjFunctionNode locals isEmpty ifTrue: [
			aPjFunctionNode needsSelf ifFalse: [^self]].
		self
			nextPutAll: 'var ';
			writeSafeNames: 	aPjFunctionNode locals.
		aPjFunctionNode needsSelf ifTrue: [	
			aPjFunctionNode locals isEmpty ifFalse: [ self nextPut: $, ].
			self
				nextPutAll: self class selfName;
				nextPutAll: '=this'
		].
		self nextPut: $;
	
]

{ #category : #writing }
PjStringGenerator >> writeJsSelector: aSelector onStream: aStream [
	| isBinary |
	(aSelector beginsWith: self jsNativePrefix) ifTrue: [ 
			^ aStream nextPutAll: ((aSelector keywords first allButFirst: self jsNativePrefix size) copyWithout: $:) ].
	isBinary := aSelector isBinary.
	aStream nextPutAll: self pharoJsSelectorPrefix.
	aSelector do:[ :each | 
			self writeSelectorChar: each on: aStream isInBinarySelector: isBinary ]
]

{ #category : #writing }
PjStringGenerator >> writeNonBrace: aCharacterOrString [
	aCharacterOrString isString ifTrue: [
		self nextPutAll: aCharacterOrString
	] ifFalse:  [
		self nextPut: aCharacterOrString
	].
	wroteCloseBrace := false.

]

{ #category : #writing }
PjStringGenerator >> writeSafeNames: aCollection [
	aCollection do: [ : each | 
		self writeVariable: each escapingIfIn: JsReservedWordsForVariables ]
	separatedBy: [ self nextPut: $, ]
]

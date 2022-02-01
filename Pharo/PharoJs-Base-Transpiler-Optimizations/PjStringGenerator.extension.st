Extension { #name : #PjStringGenerator }

{ #category : #'*PharoJs-Base-Transpiler-Optimizations-Optimizations' }
PjStringGenerator >> trueTest: test [
	| comparator testExpression |
	comparator := true.
	testExpression := test.
	[ testExpression isNot ] whileTrue: [
		comparator := comparator not.
		testExpression := testExpression not ].
	testExpression isComparison ifTrue: [
		comparator ifFalse: [ testExpression := testExpression not ].
		^ self visit: testExpression ].
	self
		print: comparator;
		nextPutAll: '==';
		atPrecedence: EqualityPrecedence+0.5 do: [self visit: testExpression]
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations-Optimizations' }
PjStringGenerator >> visitIfNilIfNotNilNode: aPjIfNilIfNotNilNode [
	| then else |
	then := aPjIfNilIfNotNilNode whenNil.
	else := aPjIfNilIfNotNilNode whenNotNil.
	self isAtStatementPrecedence ifFalse: [
		^ self writeIfNilExpression: aPjIfNilIfNotNilNode test then: then else: else
	].
	self
		nextPutAll: 'if(';
		atPrecedence: EqualityPrecedence do: [ aPjIfNilIfNotNilNode test acceptVisitor: self ];
		nextPutAll: '==';
		nextPutAll: self class nilInJavascript;
		writeNonBrace: '){';
		visit: then;
		maybeWriteSemicolon;
		nextPutAll: '}else{';
		visit: else;
		writeNonBrace: $}
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations-Optimizations' }
PjStringGenerator >> visitIfNilNode: aPjIfNilNode [ 
	| then |
	then := aPjIfNilNode whenNil.
	self isAtStatementPrecedence ifFalse: [
		^ self writeIfNilExpression: aPjIfNilNode test then: then else: PjNilNode new
	].
	self
		nextPutAll: 'if(';
		atPrecedence: EqualityPrecedence do: [ aPjIfNilNode test acceptVisitor: self ];
		nextPutAll: '==';
		nextPutAll: self class nilInJavascript;
		writeNonBrace: '){';
		visit: then;
		writeNonBrace: $}
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations-Optimizations' }
PjStringGenerator >> visitIfNotNilNode: aPjIfNotNilNode [ 
	| body |
	body := aPjIfNotNilNode whenNotNil.
	self isAtStatementPrecedence ifFalse: [
		^ self writeIfNilExpression: aPjIfNotNilNode test then: PjNilNode new else: body
	].
	self
		nextPutAll: 'if(';
		atPrecedence: EqualityPrecedence do: [ aPjIfNotNilNode test acceptVisitor: self ];
		nextPutAll: '!=';
		nextPutAll: self class nilInJavascript;
		writeNonBrace: '){';
		visit: body;
		writeNonBrace: $}
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations-Optimizations' }
PjStringGenerator >> visitIfTrueIfFalseNode: aPjIfTrueIfFalseNode [
	self isAtStatementPrecedence ifFalse: [
		^ self writeConditionalExpression: aPjIfTrueIfFalseNode test
			then: aPjIfTrueIfFalseNode whenTrue
			else: aPjIfTrueIfFalseNode whenFalse
	].
	self
		nextPutAll: 'if(';
		trueTest: aPjIfTrueIfFalseNode test;
		writeNonBrace: '){';
		visit: aPjIfTrueIfFalseNode whenTrue;
		writeNonBrace: '}else{';
		visit: aPjIfTrueIfFalseNode whenFalse;
		writeNonBrace: $}
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations-Optimizations' }
PjStringGenerator >> visitIfTrueNode: aPjIfTrueNode [
	self isAtStatementPrecedence ifFalse: [
		^ self writeConditionalExpression: aPjIfTrueNode test then: PjNilNode new else: aPjIfTrueNode whenTrue
	].
	self
		nextPutAll: 'if(';
		trueTest: aPjIfTrueNode test;
		writeNonBrace: '){';
		visit: aPjIfTrueNode whenTrue;
		writeNonBrace: $}
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations-Optimizations' }
PjStringGenerator >> visitToDoByNode: aPjToDoByNode [ 
	| step limit |
	limit := aPjToDoByNode to constantOrZero.
	self
		nextPutAll: 'for(var ';
		visit: aPjToDoByNode from.
	limit = 0 ifTrue: [
		self
			nextPut: $,;
			visit: aPjToDoByNode to].
	aPjToDoByNode by ifNil: [
		step := 1
	] ifNotNil: [
		step := aPjToDoByNode by constantOrZero.
		step = 0 ifTrue: [
			self
				nextPut: $,;
				visit: aPjToDoByNode by	].
	].
	self nextPut: $;.
	step = 0 ifTrue: [
		self
			visit: aPjToDoByNode by target;
			nextPutAll: '>=0?'].
	step >= 0 ifTrue: [
		self
			visit: aPjToDoByNode from target;
			nextPutAll: '<=';
			visit: aPjToDoByNode to target].
	step = 0 ifTrue: [	self nextPut: $:].
	step <= 0 ifTrue: [
		self
			visit: aPjToDoByNode from target;
			nextPutAll: '>=';
			visit: aPjToDoByNode to target
	].
	self nextPut: $;.
	step = 1 ifTrue: [ self nextPutAll: '++'].
	step = -1 ifTrue: [ self nextPutAll: '--'].
	self visit: aPjToDoByNode from target.
	step abs = 1 ifFalse: [
		self
			nextPutAll: '+=';
			visit: aPjToDoByNode by target
	].
	self writeLoopBody: aPjToDoByNode body
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations-Optimizations' }
PjStringGenerator >> visitWhileNode: aPjWhileNode [
	self isAtStatementPrecedence
		ifFalse: [ self error: 'PjWhileNode not at statement level' ].
	self
		nextPutAll: 'while(';
		trueTest: aPjWhileNode test.
	self writeLoopBody: aPjWhileNode body
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations-Optimizations' }
PjStringGenerator >> writeConditionalExpression: test then: thenAst else: elseAst [
	self atPrecedence: ConditionalPrecedence do: [.
		self
			trueTest: test.
		thenAst isLiteralTrue ifTrue: [
			^ self
				nextPutAll: '||';
				visit: elseAst
		].
		elseAst isLiteralFalse ifTrue: [
			^ self
				nextPutAll: '&&';
				visit: thenAst
		].
		self
			nextPut: $?;
			visit: thenAst;
			nextPut: $:;
			visit: elseAst
	]
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations-Optimizations' }
PjStringGenerator >> writeIfNilExpression: test then: thenAst else: elseAst [
	self writeConditionalExpression: (PjBinaryNode operator: #== left: test  right: PjNilNode new)
		then: thenAst 
		else: elseAst
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations-Optimizations' }
PjStringGenerator >> writeLoopBody: body [
	self writeNonBrace: '){'.
	body asOrderedCollection
		do: [ :statement | statement acceptVisitor: self ]
		separatedBy: [ self maybeWriteSemicolon ].
	self writeCloseBrace
]

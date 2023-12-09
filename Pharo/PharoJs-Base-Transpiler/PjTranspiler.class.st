"
I am a Transpiler from Smalltalk classes and objects to Javascript.

I use the PjAstConerter to convert a Smalltalk method or block to a PjJavascriptAstNode and then PjAstTo StringGenerator to convert to Javascript code.

To avoid collisions with existing JS code, we introduce a prefix for method selectors upon conversion to javascript. The prefix is defined in the class side selectorsPrefix. The default value can be changed on demand.
"
Class {
	#name : #PjTranspiler,
	#superclass : #Object,
	#traits : 'PjTStreamWriter',
	#classTraits : 'PjTStreamWriter classTrait',
	#instVars : [
		'converter',
		'generatedMethods',
		'generator',
		'jsStream',
		'neededDNUs',
		'classesReferencingCache',
		'writtenDNUs',
		'beforeCodeOutputHook',
		'shouldWriteDnu',
		'poolsUsed',
		'pharoJsSelectorPrefix',
		'instanceMethodsAliasesDict',
		'classMethodsAliasesDict'
	],
	#category : #'PharoJs-Base-Transpiler-Kernel'
}

{ #category : #accessing }
PjTranspiler class >> classVariablesHolderName [
	^ PjStringGenerator classVariablesHolderName
]

{ #category : #transpiling }
PjTranspiler class >> classVarsPoolName [
	^'cp$'
]

{ #category : #transpiling }
PjTranspiler class >> convertToJs: anObject [
	^self new convertToJs: anObject
]

{ #category : #accessing }
PjTranspiler class >> coreClass [
	^ PjCore
]

{ #category : #transpiling }
PjTranspiler class >> installAllAliasesSelector [

	^ #installAllAliases
]

{ #category : #'transpiling classes' }
PjTranspiler class >> installClassSelector [
	^#installClass
]

{ #category : #'transpiling classes' }
PjTranspiler class >> installJsClassPlaceholderSelector [

	^ #installJsClassPlaceholder
]

{ #category : #accessing }
PjTranspiler class >> lineEnding [
	^Character cr
]

{ #category : #accessing }
PjTranspiler class >> skipMethodPragmaKeyword [
	"Methods with this pragma are skipped upon conversion to javascript."
	^#pharoJsSkip
]

{ #category : #'transpiling aliases' }
PjTranspiler >> addAliasesForClassMethod: aRBMethodNode [

	self
		aliasesDict: classMethodsAliasesDict
		addForMethod: aRBMethodNode
]

{ #category : #'transpiling aliases' }
PjTranspiler >> addAliasesForInstanceMethod: aRBMethodNode [

	self
		aliasesDict: instanceMethodsAliasesDict
		addForMethod: aRBMethodNode
]

{ #category : #conversions }
PjTranspiler >> addAllConversions: aCollection [ 
	converter addAllConversions: aCollection
]

{ #category : #conversions }
PjTranspiler >> addAllOptionalConversions [
	| aCollection |
	aCollection := PjOptionalMessageConversion allSubclasses select: [: class | class includesSelector: #selector ].
	self addAllConversions: aCollection
]

{ #category : #conversions }
PjTranspiler >> addAllOptionalConversionsExcept: low to: high [
	| aCollection discard |
	aCollection := PjOptionalMessageConversion allSubclasses select: [: class | class includesSelector: #selector ].
	aCollection := aCollection sorted: [: l : r | l name < r name].
	discard := aCollection copyFrom: (low*aCollection size) asInteger+1 to: (high*aCollection size) asInteger.
	self addAllConversions: (aCollection reject: [: each | discard includes: each ]).
	discard inspect.
]

{ #category : #'transpiling aliases' }
PjTranspiler >> aliasesDict: aDict addForMethod: aRBMethodNode [
	aRBMethodNode pragmas
		select: [ :pragma | pragma selector beginsWith: #jsAlias: ]
		thenDo: [ :pragma | 
		self aliasesDict: aDict at: aRBMethodNode selector addAll: pragma arguments ]
]

{ #category : #'transpiling aliases' }
PjTranspiler >> aliasesDict: aliasesDict at: methodSelector addAll: newAliases [

	| aliases |
	aliases := aliasesDict
		           at: methodSelector
		           ifAbsentPut: [ Set new ].
	aliases addAll: newAliases
]

{ #category : #accessing }
PjTranspiler >> beforeCodeOutputHook: aBlockClosure [ 
	beforeCodeOutputHook := aBlockClosure
]

{ #category : #accessing }
PjTranspiler >> classVariablesHolderName [
	^ self class classVariablesHolderName
]

{ #category : #transpiling }
PjTranspiler >> classVarsPoolName [
	^self class classVarsPoolName
]

{ #category : #'transpiling classes' }
PjTranspiler >> convertAllClasses: classes [

	| actualClassesToConvert classesInWriteOrder |
	beforeCodeOutputHook ifNotNil: [ beforeCodeOutputHook value ].
	actualClassesToConvert := classes asIdentitySet collect:
		                          #classToUseForJsConversion.
	classesInWriteOrder := self orderForWriting: actualClassesToConvert.
	classesInWriteOrder do: [ :aClass | 
		self writeClassDefinitionOf: aClass. ].
	self writeDnuList.
	self writeClassInitializeOfAll: classesInWriteOrder
]

{ #category : #'transpiling classes' }
PjTranspiler >> convertAllClasses: classes writeDnu: aBoolean [
	self 
		enableWriteDnu: aBoolean
		during: [self convertAllClasses: classes].
]

{ #category : #transpiling }
PjTranspiler >> convertAndWriteClosedBlock: valuedBlock [ 
	self convertAndWriteClosedBlock: valuedBlock with: [ ]
]

{ #category : #transpiling }
PjTranspiler >> convertAndWriteClosedBlock: valuedBlock with: aBlock [
	| jsAst |
	jsAst := converter convertValuedBlock: valuedBlock.
	aBlock value.
	generator asString: jsAst on: self jsStream.
	jsStream
		nextPut: $;;
		cr
]

{ #category : #transpiling }
PjTranspiler >> convertBlock: aBlock [ 
	| jsAst |
	jsAst := converter convertBlock: aBlock.
	^self generateCodeStringFrom: jsAst.
]

{ #category : #'transpiling classes' }
PjTranspiler >> convertClass: aClass [

	| actualClassToConvert |
	actualClassToConvert := aClass classToUseForJsConversion.
	self writeClassDefinitionOf: actualClassToConvert.
	self writeClassInitializeOf: actualClassToConvert
]

{ #category : #transpiling }
PjTranspiler >> convertClosedBlock: closedBlock [ 
	| jsAst |
	jsAst := converter convertClosedBlock: closedBlock.
	^self generateCodeStringFrom: jsAst.
]

{ #category : #transpiling }
PjTranspiler >> convertSmalltalkString: aString [
	self transpileMethod: (nil class compiler source: (ReadStream on: 'transpile ^',aString); receiver: nil class ; compile)
]

{ #category : #transpiling }
PjTranspiler >> convertToJs: anObject [
	^ self onTempStreamDo: [anObject convertToJsUsing: self]
]

{ #category : #transpiling }
PjTranspiler >> convertValuedBlock: valuedBlock [ 
	| jsAst |
	jsAst := converter convertValuedBlock: valuedBlock.
	^self generateCodeStringFrom: jsAst.
]

{ #category : #accessing }
PjTranspiler >> coreClass [
	^ self class coreClass
]

{ #category : #initialization }
PjTranspiler >> defaultConverterClass [
	^PjAstConverter
]

{ #category : #initialization }
PjTranspiler >> defaultGeneratorClass [
	^PjStringGenerator
]

{ #category : #initialization }
PjTranspiler >> defaultMessageConversions [
	^ { PjJsThisConversion. PjJsAtConversion. PjJsAtPutConversion }
]

{ #category : #transpiling }
PjTranspiler >> disableWriteDnuDuring: aBlockClosure [ 
	^self enableWriteDnu: false during: aBlockClosure
]

{ #category : #loading }
PjTranspiler >> discoveredGlobalsPool: aClass [
	"To be used for loading polyfills"
	^self
]

{ #category : #loading }
PjTranspiler >> discoveredMessage: aSymbol [
	neededDNUs add: aSymbol
]

{ #category : #loading }
PjTranspiler >> discoveredReferenceToClass: aClass [
	"To be used for dynamic class and method loading"
	^self
]

{ #category : #transpiling }
PjTranspiler >> dnuJsString [
	^ self enableWriteDnuDuring: [self onTempStreamDo: [self writeDnuList]]
]

{ #category : #ordering }
PjTranspiler >> does: last reference: first [
	| classesReferencingFirst |
	classesReferencingFirst := classesReferencingCache
		at: first
		ifAbsentPut: [ | methodsReferencingFirst |
			methodsReferencingFirst := SystemNavigation
				globalRefsForPharoJS: first classToUseForJsConversion name.
			methodsReferencingFirst asSet
				collect: [ :each | each methodClass instanceSide ] ].
	(classesReferencingFirst includes: last)
		ifTrue: [ ^ true ].
	classesReferencingFirst
		detect: [ :each | last inheritsFrom: each ]
		ifFound: [ ^ true ].
	(last sharedPools includes: first)
		ifTrue: [ ^ true ].
	^ false
]

{ #category : #transpiling }
PjTranspiler >> enableWriteDnu: aBoolean during: aBlockClosure [ 
	| initialShouldWriteDnu |
	initialShouldWriteDnu := self shouldWriteDnu.
	self shouldWriteDnu: aBoolean.
	^aBlockClosure ensure: [ self shouldWriteDnu: initialShouldWriteDnu ]
]

{ #category : #transpiling }
PjTranspiler >> enableWriteDnuDuring: aBlockClosure [ 
	^self enableWriteDnu: true during: aBlockClosure
]

{ #category : #loading }
PjTranspiler >> findClassesFor: aClass [
	^ { aClass }, aClass allSuperclasses
]

{ #category : #transpiling }
PjTranspiler >> generateCodeStringFrom: jsAst [
	generator asString: jsAst on: self jsStream
]

{ #category : #initialization }
PjTranspiler >> initialize [
	super initialize.
	generatedMethods := Dictionary new.
	converter := self defaultConverterClass new.
	converter transpiler: self.
	converter addAllMessageConversions: self defaultMessageConversions.
	generator := self defaultGeneratorClass new transpiler: self.
	self shouldWriteDnu: true.
	neededDNUs := Set new.
	writtenDNUs := Set new.
	poolsUsed := IdentityDictionary new.
	classesReferencingCache := IdentityDictionary new.
	self pharoJsSelectorPrefix: '_'.
]

{ #category : #'transpiling aliases' }
PjTranspiler >> installAllAliasesSelector [
	^self class installAllAliasesSelector
]

{ #category : #'transpiling classes' }
PjTranspiler >> installClassSelector [

	^ self class installClassSelector
]

{ #category : #'transpiling classes' }
PjTranspiler >> installJsClassPlaceholderSelector [

	^ self class installJsClassPlaceholderSelector
]

{ #category : #'transpiling classes' }
PjTranspiler >> installSelectorFor: aClass [

	^ aClass isJsClassPlaceholder
		  ifTrue: [ self installJsClassPlaceholderSelector ]
		  ifFalse: [ self installClassSelector ]
]

{ #category : #accessing }
PjTranspiler >> jsCode [
	^ self jsStream contents trim
]

{ #category : #accessing }
PjTranspiler >> jsStream [
	^jsStream ifNil: [ jsStream := '' writeStream ]
]

{ #category : #accessing }
PjTranspiler >> lineEnding [
	^self class lineEnding
]

{ #category : #ordering }
PjTranspiler >> moveHighestPriorityClassesIn: initialClasses to: orderedClasses with: doesReferenceBlock [
	| nextClasses |
	nextClasses  := initialClasses select: [: aClass | 
			initialClasses noneSatisfy: [: bClass | 
				self should: bClass occurBefore: aClass with: doesReferenceBlock]].
	nextClasses isEmpty ifTrue: [ ^ converter transpilationError: 'circular class dependency' ].
	(nextClasses includes: PjObject) ifTrue: [ nextClasses size > 1 ifTrue: [self halt] ].
	initialClasses removeAll: nextClasses.
	orderedClasses addAll: nextClasses.
]

{ #category : #'transpiling classes' }
PjTranspiler >> needMetaclassFixFor: aClass [

	^ aClass isJsClassPlaceholder
]

{ #category : #outputing }
PjTranspiler >> newlyGeneratedAstsDo: aBlock [
	generatedMethods keysAndValuesDo: [ : method : ast |
		ast = #done ifFalse: [
			aBlock cull: method cull: ast.
			generatedMethods at: method put: #done
	]]
]

{ #category : #statistics }
PjTranspiler >> numberOfClasses [
	^ nil
]

{ #category : #statistics }
PjTranspiler >> numberOfMethods [
	^ nil
]

{ #category : #transpiling }
PjTranspiler >> onStream: aStream [
	jsStream := aStream
]

{ #category : #'writing low-level' }
PjTranspiler >> onTempStreamDo: aBlock [
	| saveStream |
	saveStream := jsStream.
	jsStream := '' writeStream.
	^ [
		aBlock value.
		jsStream contents
	] ensure: [ jsStream := saveStream ]
]

{ #category : #ordering }
PjTranspiler >> order: classes with: doesReferenceBlock [
	"Arrange the classes in the collection, classes, in initialization order.
	Based on Class class>>#superclassOrder:"

	| orderedClasses initialClasses cache |
	initialClasses := classes copy asOrderedCollection.
	cache := Dictionary new.
	orderedClasses := OrderedCollection new: initialClasses size.
	[initialClasses size > 0] whileTrue: [
		self
			moveHighestPriorityClassesIn: initialClasses
			to: orderedClasses
			with: doesReferenceBlock ].
	^ orderedClasses
]

{ #category : #ordering }
PjTranspiler >> orderForInitialization: classes [
	^ self order: classes with: [ : first : last |
		self does: last reference: first ]
]

{ #category : #ordering }
PjTranspiler >> orderForWriting: classes [ 
	^ self order: classes with: [ : first : last |
		last allSharedPoolsRecursive includes: first]
]

{ #category : #transpiling }
PjTranspiler >> pharoJsSelectorPrefix [
	^ pharoJsSelectorPrefix
]

{ #category : #transpiling }
PjTranspiler >> pharoJsSelectorPrefix: newSelectorsPrefix [
	pharoJsSelectorPrefix := newSelectorsPrefix.
]

{ #category : #transpiling }
PjTranspiler >> poolFor: myClass [
	^ poolsUsed at: myClass instanceSide ifAbsentPut: [OrderedCollection with: myClass instanceSide ]
]

{ #category : #transpiling }
PjTranspiler >> poolReference: aClass for: myClass [

	^ aClass nameToUseForJsConversion, '.',  self classVarsPoolName
]

{ #category : #conversions }
PjTranspiler >> removeAllConversions: aCollection [ 
	converter removeAllConversions: aCollection
]

{ #category : #'transpiling aliases' }
PjTranspiler >> resetMethodAliasesDictionaries [
	instanceMethodsAliasesDict := Dictionary new.
	classMethodsAliasesDict := Dictionary new.

]

{ #category : #accessing }
PjTranspiler >> selectorsPrefix [
	^ self pharoJsSelectorPrefix
]

{ #category : #conversions }
PjTranspiler >> setExtraBindings: aDictionary [ 
	converter setExtraBindings: aDictionary
]

{ #category : #ordering }
PjTranspiler >> should: first occurBefore: last with: doesReferenceBlock [
	first=last ifTrue: [ ^false ].
	(last javascriptInheritsFrom: first) ifTrue: [ ^true ].
	(first javascriptInheritsFrom: last) ifTrue: [ ^false ].
	^ doesReferenceBlock value: first value: last
]

{ #category : #'transpiling methods' }
PjTranspiler >> shouldSkipMethodNode: aRBMethodNode [
	^aRBMethodNode hasPragmaNamed: self skipMethodPragmaKeyword
]

{ #category : #accessing }
PjTranspiler >> shouldWriteDnu [
	^ shouldWriteDnu
]

{ #category : #accessing }
PjTranspiler >> shouldWriteDnu: anObject [
	shouldWriteDnu := anObject
]

{ #category : #accessing }
PjTranspiler >> skipMethodPragmaKeyword [
	^self class skipMethodPragmaKeyword
]

{ #category : #'transpiling methods' }
PjTranspiler >> transpileMethod: aMethod [
	| jsAst |
	jsAst := converter
		convertAst: aMethod ast
		withPrimitive: aMethod primitive.
	generator asString: jsAst on: self jsStream
]

{ #category : #'transpiling methods' }
PjTranspiler >> transpileMethodToString: aMethod [
	^ self onTempStreamDo: [ self transpileMethod: aMethod ]
]

{ #category : #'transpiling methods' }
PjTranspiler >> withMethodsNoSkipOf: aClass do: aBlock [
	self withMethodsOf: aClass do: [ :method | 
		(self shouldSkipMethodNode: method) ifFalse: [aBlock value: method] ]
]

{ #category : #'transpiling methods' }
PjTranspiler >> withMethodsOf: aClass do: aBlock [
	aClass selectorsWithExplicitOrigin do: [ : selector |
		 aBlock value: (aClass compiledMethodAt: selector) ]
]

{ #category : #'transpiling aliases' }
PjTranspiler >> writeAssociationKey: selector values: aliases [

self
				<< $";
				writeJsSelector: selector;
				<< '":['.
			aliases
				do: [ :each | self print: each ]
				separatedBy: [ self << $, ].
			self << $] 

]

{ #category : #'transpiling classes' }
PjTranspiler >> writeClassDeclarationOf: aClass [

aClass isJsClassPlaceholder ifTrue: [ ^self writeClassExtensionDeclarationOf: aClass ].
	self << 'class';
			space;
			writeNameForClass: aClass; 
		space;
		<< 'extends';
		space; 
		writeNameForClass: aClass superclass 
]

{ #category : #'transpiling classes' }
PjTranspiler >> writeClassDefinitionOf: aClass [

	self resetMethodAliasesDictionaries.
	self
		writeNameForClass: PjCore;
		<< '.';
		<< (self installSelectorFor: aClass);
		<< $(;
		writeClassDeclarationOf: aClass;
		<< ${;
		cr;
		writeInitializeSupportFor: aClass;
		writeMethodsOf: aClass;
		writeClassVariableDeclarationsOf: aClass;
		<< '},'.
	aClass isJsClassPlaceholder ifTrue: [
		self
			writeNameForClass: aClass;
			<< $, ].
	self
		writeInstanceMethodsAliasesDict;
		<< $,;
		writeClassMethodsAliasesDict;
		<< ');'.
	self writeInheritedClassInstanceVariablesFixFor: aClass
]

{ #category : #'transpiling classes' }
PjTranspiler >> writeClassExtensionDeclarationOf: aClass [

	self
		<< 'class';
		space;
		<< 'extends';
		space;
		<< '(';
		writeNameForClass: aClass;
		<< '.__proto__.prototype == null  ? Object :';
		writeNameForClass: aClass;
		<< '.__proto__)'
]

{ #category : #transpiling }
PjTranspiler >> writeClassInitializeOf: aClass [
	aClass needsInitialization ifFalse: [^self].  
	self 
		writeNameForClass: aClass;
		nextPutAll: '.', self pharoJsSelectorPrefix, aClass classInitializeSelector, '();';
		cr
]

{ #category : #transpiling }
PjTranspiler >> writeClassInitializeOfAll: classesInWriteOrder [
	| sortedClassesToInit classesToInit |
	classesToInit := classesInWriteOrder select: #needsInitialization.
	sortedClassesToInit := self orderForInitialization: classesToInit.
	^ sortedClassesToInit
		do: [ :aClass | self writeClassInitializeOf: aClass ]
]

{ #category : #'transpiling aliases' }
PjTranspiler >> writeClassMethodsAliasesDict [

	self writeMethodAliasesDict: classMethodsAliasesDict
]

{ #category : #'transpiling methods' }
PjTranspiler >> writeClassMethodsOf: aClass [

	self withMethodsNoSkipOf: aClass class do: [ :aRBMethodNode | 
		self
			<< 'static ';
			transpileMethod: aRBMethodNode;
			addAliasesForClassMethod:aRBMethodNode ;
			cr ]
]

{ #category : #transpiling }
PjTranspiler >> writeClassVarNamesOf: aClass [

	aClass classPool keys
		do: [ :classVarName | 
			self
				nextPut: $";
				nextPutAll: classVarName;
				nextPut: $";
				nextPutAll: ':null' ]
		separatedBy: [ self nextPut: $, ]
]

{ #category : #transpiling }
PjTranspiler >> writeClassVariableDeclarationsOf: aClass [

	self
		nextPutAll: 'static';
		space;
		writeClassVarsPoolName;
		nextPutAll: '={';
		writeClassVarNamesOf: aClass;
		nextPut: $}. 

]

{ #category : #transpiling }
PjTranspiler >> writeClassVarsPoolName [

	self nextPutAll: self classVarsPoolName
]

{ #category : #transpiling }
PjTranspiler >> writeDnuList [
	| selectors |
	self shouldWriteDnu ifFalse: [^self].
	selectors := neededDNUs asSortedCollection reject: [ : selector | writtenDNUs includes: selector ].
	selectors ifEmpty: [ ^ self ].
	self 
		writeNameForClass: self coreClass;
		nextPut: $.;
		nextPutAll: self pharoJsSelectorPrefix;
		nextPutAll: 'registerDnuForAll_(['.
	selectors do: [
		: selector |
			writtenDNUs add: selector.
			selector printJsOn: self
	] separatedBy: [ self nextPut: $, ].
	self 
		nextPutAll: ']);';
		cr.
	neededDNUs := Set new.
]

{ #category : #'transpiling classes' }
PjTranspiler >> writeInheritedClassInstanceVariablesFixFor: aClass [

	| transpiledClass jsClassName transpiledSuperclasses currentSuperclass |
	transpiledClass := aClass classToUseForJsConversion.
	jsClassName := transpiledClass instanceSide nameToUseForJsConversion.
	transpiledSuperclasses := Set new.
	currentSuperclass := transpiledClass superclass
		                     classToUseForJsConversion.
	[ currentSuperclass isNil or: [ currentSuperclass == PjObject ] ]
		whileFalse: [
			transpiledSuperclasses add: currentSuperclass.
			currentSuperclass := currentSuperclass superclass
				                     classToUseForJsConversion ].
	transpiledSuperclasses do: [ :each |
		each class instVarNames do: [ :ivName |
			self
				<< jsClassName;
				<< $.;
				<< ivName;
				<< '=null;' ] ]
]

{ #category : #'transpiling classes' }
PjTranspiler >> writeInitializeSupportFor: aClass [
	"We check the superclass to avoid duplicate sends of #initialize"

	aClass isJsClassPlaceholder ifTrue: [ ^ self ].
	self
		<< 'constructor(){';
		<< 'super();';
		<< 'if(!';
		writeNameForClass: aClass superclass;
		<< '.';
		writeJsSelector: #sendsInitialize;
		<< '()){this.';
		writeJsSelector: #initialize;
		<< '();}}';
		cr;
		<< 'static ';
		writeJsSelector: #sendsInitialize;
		<< '(){return true}';
		cr
]

{ #category : #'transpiling aliases' }
PjTranspiler >> writeInstallMethodAliasesOf: aClass [

	(instanceMethodsAliasesDict isEmpty and: [ 
		 classMethodsAliasesDict isEmpty ]) ifTrue: [ ^ self ].
	self
		writeNameForClass: PjCore;
		<< $.;
		<< self installAllAliasesSelector;
		<< $(;
		writeInstanceMethodsAliasesDict;
		<< $,;
		writeClassMethodsAliasesDict;
		<< $,;
		writeNameForClass: aClass;
		<< $,;
		writeNameForClass: aClass;
		<< ');';
		cr
]

{ #category : #'transpiling aliases' }
PjTranspiler >> writeInstanceMethodsAliasesDict [
	self writeMethodAliasesDict: instanceMethodsAliasesDict 
]

{ #category : #'transpiling methods' }
PjTranspiler >> writeInstanceMethodsOf: aClass [

	self withMethodsNoSkipOf: aClass do: [ :aRBMethodNode | 
		self
			transpileMethod: aRBMethodNode;
			addAliasesForInstanceMethod: aRBMethodNode;
			cr ]
]

{ #category : #transpiling }
PjTranspiler >> writeInstanceVariable: cvName [
	self writeVariable: cvName escapingIfIn: PjStringGenerator JsReservedWordsForInstanceVariables
]

{ #category : #writing }
PjTranspiler >> writeList: aCollection withPrefix: aString [ 
	aCollection do: [: each |
		self jsStream nextPutAll: aString;nextPutAll: each
	]
]

{ #category : #'transpiling aliases' }
PjTranspiler >> writeMethodAliasesDict: aliasesDict [

	self << ${.
	aliasesDict keys
		do: [ :selector | 
			self
				writeAssociationKey: selector
				values: (aliasesDict at: selector) ]
		separatedBy: [ self << $, ].
	self << $}
]

{ #category : #'transpiling methods' }
PjTranspiler >> writeMethodsOf: aClass [

	converter classForConversion: aClass.
	self
		writeInstanceMethodsOf: aClass;
		writeClassMethodsOf: aClass
]

{ #category : #'transpiling classes' }
PjTranspiler >> writeNameForClass: aClass [
	self nextPutAll: aClass instanceSide nameToUseForJsConversion
]

{ #category : #'transpiling methods' }
PjTranspiler >> writeSendsInitializeClassMethod [
	"This method is used to support sending initialize when a PharoJS generated class is instantiated in plain JS code using the `new` operator as in `new MyPharoJSClass()`. "

	" See `PjTranspiler>>#writeConstructor` and `PjObject class>>#sendsInitialize`"

	self
		<< 'static ';
		writeJsSelector: #sendsInitialize;
		<< '{return true}'
]

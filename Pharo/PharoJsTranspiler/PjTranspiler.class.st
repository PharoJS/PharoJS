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
		'shouldWriteDnu'
	],
	#classInstVars : [
		'pharoJsSelectorPrefix'
	],
	#category : #'PharoJsTranspiler-Kernel'
}

{ #category : #accessing }
PjTranspiler class >> classVariablesHolderName [
	^ PjStringGenerator classVariablesHolderName
]

{ #category : #transpiling }
PjTranspiler class >> convertToJs: anObject [
	^self new convertToJs: anObject
]

{ #category : #accessing }
PjTranspiler class >> coreClass [
	^ PjCore
]

{ #category : #'class initialization' }
PjTranspiler class >> defaultPharoJsSelectorPrefix [
	^'pj_'
]

{ #category : #'class initialization' }
PjTranspiler class >> initialize [
	self pharoJsSelectorPrefix: self defaultPharoJsSelectorPrefix
]

{ #category : #accessing }
PjTranspiler class >> lineEnding [
	^Character cr
]

{ #category : #transpiling }
PjTranspiler class >> pharoJsSelectorPrefix [
	^pharoJsSelectorPrefix
]

{ #category : #transpiling }
PjTranspiler class >> pharoJsSelectorPrefix: newSelectorsPrefix [
	pharoJsSelectorPrefix := newSelectorsPrefix
]

{ #category : #accessing }
PjTranspiler class >> skipMethodPragmaKeyword [
	"Methods with this pragma are skipped upon conversion to javascript."
	^#pharoJsSkip
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

{ #category : #accessing }
PjTranspiler >> beforeCodeOutputHook: aBlockClosure [ 
	beforeCodeOutputHook := aBlockClosure
]

{ #category : #accessing }
PjTranspiler >> classVariablesHolderName [
	^ self class classVariablesHolderName
]

{ #category : #transpiling }
PjTranspiler >> convertAllClasses: classes [
	| actualClassesToConvert classesInWriteOrder |
	beforeCodeOutputHook ifNotNil: [ beforeCodeOutputHook value ].
	actualClassesToConvert := classes asIdentitySet collect: #classToUseForJsConversion.
	classesInWriteOrder := self orderForWriting: actualClassesToConvert.
	classesInWriteOrder
		do: [ :aClass | 
			self writeClassInheritanceLinksOf: aClass.
			self writeClassAndPoolVariablesDeclarationOf: aClass.
			self writeMethodsOf: aClass ].
	self writeDnuList.
	self writeClassInitializeOfAll: classesInWriteOrder
]

{ #category : #transpiling }
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
	jsStream nextPut: $;; cr.

]

{ #category : #transpiling }
PjTranspiler >> convertBlock: aBlock [ 
	| jsAst |
	jsAst := converter convertBlock: aBlock.
	^self generateCodeStringFrom: jsAst.
]

{ #category : #transpiling }
PjTranspiler >> convertClass: aClass [ 
	| actualClassToConvert | 
	actualClassToConvert := aClass classToUseForJsConversion.
	self writeClassDefinitionOf: actualClassToConvert.
	self writeClassInheritanceLinksOf: actualClassToConvert.
	self writeClassAndPoolVariablesDeclarationOf: actualClassToConvert.
	self writeMethodsOf: actualClassToConvert.
	self writeClassInitializeOf: actualClassToConvert.

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
				collect: [ :each | each actualClass instanceSide ] ].
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
PjTranspiler >> generateCodeStringFrom: jsAst. [
	generator asString: jsAst on: self jsStream
]

{ #category : #initialization }
PjTranspiler >> initialize [
	super initialize.
	generatedMethods := Dictionary new.
	converter := self defaultConverterClass new.
	converter transpiler: self.
	converter addAllMessageConversions: self defaultMessageConversions.
	generator := self defaultGeneratorClass new.
	self shouldWriteDnu: true.
	neededDNUs := Set new.
	writtenDNUs := Set new.
	classesReferencingCache := IdentityDictionary new.

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
	[
		aBlock value.
		^ jsStream contents
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

{ #category : #conversions }
PjTranspiler >> removeAllConversions: aCollection [ 
	converter removeAllConversions: aCollection
]

{ #category : #'as yet unclassified' }
PjTranspiler >> selectorsPrefix [
	^PjTranspiler pharoJsSelectorPrefix
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

{ #category : #transpiling }
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

{ #category : #transpiling }
PjTranspiler >> transpileMethod: aMethod [
	| jsAst |.
	jsAst := converter convertAst: aMethod ast withPrimitive: aMethod primitive.
  	generator asString: jsAst on: self jsStream.
]

{ #category : #transpiling }
PjTranspiler >> withMethodsOf: aClass do: aBlock [
	aClass selectorsWithExplicitOrigin do: [ : selector |
		 aBlock value: (aClass compiledMethodAt: selector) ]

]

{ #category : #transpiling }
PjTranspiler >> writeClassAndPoolVariablesDeclarationOf: aClass [
	| isSharedPool allClassVarNames |
	aClass classVariables isEmpty ifTrue: [(aClass sharedPools reject: #isJavascriptGlobalsPool) isEmpty ifTrue: [ ^ self ]].
	allClassVarNames := aClass allClassVarNames asSet.
	isSharedPool := aClass inheritsFrom: SharedPool.
	self
		nextPutAll: '(function($$){'.
	aClass classVarNames do: [ : cvName |
		self cr;
			nextPutAll: '$$.';
			writeInstanceVariable: cvName;
			nextPutAll: '_=function($0){return ';
			nextPutAll: '$$.';
			writeInstanceVariable: cvName;
			nextPutAll: '=$0};'.
		isSharedPool ifTrue: [
			self
				nextPutAll: '$$.';
				writeInstanceVariable: cvName;
				nextPutAll: '$=function(){return ';
				nextPutAll: '$$.';
				writeInstanceVariable: cvName;
				nextPut: $}			
	]].
	(aClass allSharedPools reject: #isJavascriptGlobalsPool) do: [: poolClass |
		poolClass classVarNames do: [ : cvName |
			(allClassVarNames includes: cvName) ifFalse: [
				self cr;
					nextPutAll: '$$.';
					writeInstanceVariable: cvName;
					nextPutAll: '_=';
					writeNameForClass: poolClass;
					nextPut: $.;
					nextPutAll: self classVariablesHolderName;
					nextPut: $.;
					writeInstanceVariable: cvName;
					nextPutAll: '_;$$.';		
					writeInstanceVariable: cvName;
					nextPutAll: '$=';
					writeNameForClass: poolClass;
					nextPut: $.;
					nextPutAll: self classVariablesHolderName;
					nextPut: $.;
					writeInstanceVariable: cvName;
					nextPut: $$
	]]].
	self
		nextPutAll: '})(';
		writeNameForClass: aClass;
		nextPutAll: '.prototype);';cr
]

{ #category : #transpiling }
PjTranspiler >> writeClassDefinitionOf: aClass [
	aClass needsClassDefinition ifFalse: [ ^self ].
	self 
		nextPutAll: 'function ';
		writeNameForClass: aClass;
		nextPutAll: '(){};';
		cr
]

{ #category : #transpiling }
PjTranspiler >> writeClassInheritanceLinksOf: aClass [
	self 
		writeNameForClass: aClass superclass;
		nextPutAll: '.', self pharoJsSelectorPrefix, 'subclass_("';
		writeNameForClass: aClass;
		nextPutAll: '");' ;
		cr.

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

{ #category : #transpiling }
PjTranspiler >> writeDnuList [
	| selectors |
	self shouldWriteDnu ifFalse: [^self].
	selectors := neededDNUs asSortedCollection reject: [ : selector | writtenDNUs includes: selector ].
	selectors ifEmpty: [ ^ self ].
	self 
		writeNameForClass: self coreClass;
		nextPut: $.;
		nextPutAll: PjTranspiler pharoJsSelectorPrefix;
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

{ #category : #transpiling }
PjTranspiler >> writeInstanceVariable: cvName [
	self writeVariable: cvName escapingIfIn: PjStringGenerator JsReservedWordsForInstanceVariables
]

{ #category : #writing }
PjTranspiler >> writeJsSelector: aSelector onStream: aStream [
	| isBinary |
	(aSelector beginsWith: self jsNativePrefix) ifTrue: [ 
			^ aStream nextPutAll: ((aSelector keywords first allButFirst: self jsNativePrefix size) copyWithout: $:) ].
	isBinary := aSelector isBinary.
	aStream nextPutAll: self pharoJsSelectorPrefix.
	aSelector do:[ :each | 
			self writeSelectorChar: each on: aStream isInBinarySelector: isBinary ]
]

{ #category : #transpiling }
PjTranspiler >> writeMethodsOf: aClass [
	| className |
	className := aClass nameToUseForJsConversion.
	self writeMethodsOf: aClass named: className  with: '.prototype'.
	self writeMethodsOf: aClass class named: className with: '.__proto__'
]

{ #category : #transpiling }
PjTranspiler >> writeMethodsOf: aClass named: aName with: reference [
	"Use JS Object.defineProperty() to ensure that methods are not enumeratable. 
	This is typically required by some third party libraries that create instances of Object, 
	and expect that no property is available for enumeration. 
	We set the writable attribute to true to enable reflection (e.g. replacing the method)."
	converter classForConversion: aClass.
	self withMethodsOf: aClass do: [ :method |
		(self shouldSkipMethodNode: method) ifFalse: [
			self 
				nextPutAll: aName;
				nextPutAll: reference;
				nextPutAll: '.$def(';
				transpileMethod: method;
				nextPutAll: ');';
				cr
	]]
]

{ #category : #transpiling }
PjTranspiler >> writeNameForClass: aClass [
	self nextPutAll: aClass nameToUseForJsConversion
]

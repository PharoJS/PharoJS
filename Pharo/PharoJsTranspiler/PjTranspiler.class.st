"
I am a Transpiler from Smalltalk classes and objects to Javascript.

I use the PjAstConerter to convert a Smalltalk method or block to a PjJavascriptAstNode and then PjAstTo StringGenerator to convert to Javascript code.
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
		'writtenDNUs'
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

{ #category : #accessing }
PjTranspiler class >> lineEnding [
	^Character cr
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
PjTranspiler >> classVariablesHolderName [
	^ self class classVariablesHolderName
]

{ #category : #transpiling }
PjTranspiler >> convertAllClasses: classes [
	self convertAllClasses: classes writeDnuAndBeforeInitializationHook: true
]

{ #category : #transpiling }
PjTranspiler >> convertAllClasses: classes writeDnuAndBeforeInitializationHook: hook [
	| actualClassesToConvert classesToInit sortedClassesToInit classesInWriteOrder |
	actualClassesToConvert := classes collect: #classToUseForJsConversion.
	actualClassesToConvert asIdentitySet do: [ :aClass | self writeClassDefinitionOf: aClass ].
"	Transcript
		nextPutAll: 'orderForInitialization for ';print: actualClassesToConvert size;
		nextPutAll: ' classes takes: ';print: ["
	classesInWriteOrder := self orderForWriting: actualClassesToConvert.
"	] timeToRun;cr;flush."
	classesInWriteOrder do: [ :aClass | 
			self writeClassInheritanceLinksOf: aClass.
			self writeClassAndPoolVariablesDeclarationOf: aClass.
			self writeMethodsOf: aClass ].
	hook value ifTrue: [ self writeDnuList ].
	classesToInit := classesInWriteOrder select: #needsInitialization.
	sortedClassesToInit := self orderForInitialization: classesToInit.
	sortedClassesToInit do: [ :aClass | self writeClassInitializeOf: aClass ]
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
PjTranspiler >> convertBlock: closedBlock [ 
	| jsAst |
	jsAst := converter convertBlock: closedBlock.
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

{ #category : #loading }
PjTranspiler >> discoveredMessage: aSymbol [
	neededDNUs add: aSymbol
]

{ #category : #loading }
PjTranspiler >> discoveredReferenceToClass: aClass [
	"To be used for dynamic class and method loading"
	^self
]

{ #category : #ordering }
PjTranspiler >> does: last reference: first [
	| classesReferencingFirst |
	classesReferencingFirst := classesReferencingCache
			at: first
			ifAbsentPut: [| methodsReferencingFirst |
				methodsReferencingFirst := SystemNavigation default classRefsToClassName: first classToUseForJsConversion name.
				methodsReferencingFirst asSet collect: [ : each | each actualClass theNonMetaClass]].
	(classesReferencingFirst includes: last) ifTrue: [ ^true ].
	classesReferencingFirst detect: [ : each | last inheritsFrom: each ] ifFound: [^true].
	(last sharedPools includes: first) ifTrue: [ ^true ].
	^false
   
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
	generatedMethods := Dictionary new.
	converter := self defaultConverterClass new.
	converter transpiler: self.
	converter addAllMessageConversions: self defaultMessageConversions.
	generator := self defaultGeneratorClass new.
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
PjTranspiler >> moveHighestPriorityClassIn: initialClasses to: orderedClasses with: doesReferenceBlock [
	| nextClassIndex nextClass |
	nextClassIndex := initialClasses findFirst: [ :aClass | 
			initialClasses noneSatisfy: [ :each | 
				self should: each occurBefore: aClass with: doesReferenceBlock]].
	nextClassIndex = 0 ifTrue: [ ^ converter transpilationError: 'circular class dependency' ].
	nextClass := initialClasses at: nextClassIndex.
	initialClasses removeAt: nextClassIndex.
	orderedClasses addLast: nextClass.

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
	initialClasses size timesRepeat: [
		self
			moveHighestPriorityClassIn: initialClasses
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
		last sharedPools includes: first ]
]

{ #category : #conversions }
PjTranspiler >> removeAllConversions: aCollection [ 
	converter removeAllConversions: aCollection
]

{ #category : #conversions }
PjTranspiler >> setExtraBindings: aDictionary [ 
	converter setExtraBindings: aDictionary
]

{ #category : #ordering }
PjTranspiler >> should: first occurBefore: last with: doesReferenceBlock [
	first=last ifTrue: [ ^false ].
	(last inheritsFrom: first) ifTrue: [ ^true ].
	(first inheritsFrom: last) ifTrue: [ ^false ].
	^ doesReferenceBlock value: first value: last

]

{ #category : #transpiling }
PjTranspiler >> shouldSkipMethodNode: aRBMethodNode [
	^aRBMethodNode hasPragmaNamed: self skipMethodPragmaKeyword
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
	aClass methodsDo: aBlock
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
		nextPutAll: '._subclass_(';
		writeNameForClass: aClass;
		nextPutAll: ');' ;
		cr.

]

{ #category : #transpiling }
PjTranspiler >> writeClassInitializeOf: aClass [
	aClass needsInitialization ifFalse: [^self].  
	self 
		writeNameForClass: aClass;
		nextPutAll: '._', aClass classInitializeSelector, '();';
		cr
]

{ #category : #transpiling }
PjTranspiler >> writeDnuList [
	| selectors |
	selectors := neededDNUs asSortedCollection reject: [ : selector | writtenDNUs includes: selector ].
	selectors ifEmpty: [ ^ self ].
	self 
		writeNameForClass: self coreClass;
		nextPutAll: '._registerDnuForAll_(['.
	selectors do: [
		: selector |
			writtenDNUs add: selector.
			selector printJsOn: self
	] separatedBy: [ self nextPut: $, ].
	self nextPutAll: ']);';cr.
	neededDNUs := Set new.

]

{ #category : #transpiling }
PjTranspiler >> writeInstanceVariable: cvName [
	self writeVariable: cvName escapingIfIn: PjStringGenerator JsReservedWordsForInstanceVariables
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
	converter classForConversion: aClass.
	self withMethodsOf: aClass do: [ :method |
		(self shouldSkipMethodNode: method) ifFalse: [
			self 
				nextPutAll: aName;
				nextPutAll: reference;
				nextPut: $. ;
				writeJsSelector: method selector onStream: jsStream;
				nextPutAll: ' = ';
				transpileMethod: method;
				cr
	]]
]

{ #category : #transpiling }
PjTranspiler >> writeNameForClass: aClass [
	self nextPutAll: aClass nameToUseForJsConversion
]

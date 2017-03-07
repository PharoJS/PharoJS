"
I am a PjTranspiler where convertAllClasses: automatically includes any classes required by the given classes
"
Class {
	#name : #PjDependentTranspiler,
	#superclass : #PjTranspiler,
	#instVars : [
		'convertedMethods',
		'classesToConvert',
		'convertedClasses',
		'alreadyDefinedClasses',
		'alreadyInitializedClasses',
		'alreadyInheritanceLinkedClasses',
		'alreadyVariablesDeclaredClasses',
		'globalPools'
	],
	#category : #'PharoJsExporter-Kernel'
}

{ #category : #accessing }
PjDependentTranspiler class >> lineEnding [
	^Character lf
]

{ #category : #transpiling }
PjDependentTranspiler >> addClassToConvert: aClass [
	aClass javascriptIsExportableClass ifFalse: [ ^ converter transpilationError: 'non-exportable class ',aClass name,' referenced' ].
	classesToConvert add: aClass classToUseForJsConversion.

]

{ #category : #transpiling }
PjDependentTranspiler >> addClassesToConvert: 	classes [
	classes do: [ : aClass | self addClassToConvert: aClass ]
]

{ #category : #loading }
PjDependentTranspiler >> alreadyConvertedClasses: classes [
	convertedClasses addAll: classes
]

{ #category : #accessing }
PjDependentTranspiler >> beforeCodeOutputHook: aBlock [
	super beforeCodeOutputHook: [ aBlock value: globalPools ]
]

{ #category : #transpiling }
PjDependentTranspiler >> convertAllClasses: classes writeDnu: shouldWriteDnu [
	| newClasses |
	self addClassesToConvert: (classes select: #javascriptIsExportableClass).
	newClasses := OrderedCollection new.
	[ classesToConvert isEmpty ] whileFalse: [ | theseClasses |
		theseClasses := classesToConvert.
		classesToConvert := Set new.
		theseClasses do: [: aClass |
			self
				convertMethodAsts: aClass theNonMetaClass
				newClasses: newClasses
	]].
	super convertAllClasses: newClasses writeDnu: shouldWriteDnu
]

{ #category : #transpiling }
PjDependentTranspiler >> convertAndWriteClosedBlock: valuedBlock [ 
	self convertAndWriteClosedBlock: valuedBlock with: [
		self convertAllClasses: #() writeDnu: true
	]
]

{ #category : #transpiling }
PjDependentTranspiler >> convertClass: aClass [ 
	self convertAllClasses: { aClass } writeDnu: false
]

{ #category : #transpiling }
PjDependentTranspiler >> convertMethodAst: aMethod [
	(self shouldSkipMethodNode: aMethod) ifTrue: [ ^self ].
	convertedMethods at: aMethod ifAbsentPut: [
		converter
			classForConversion: aMethod methodClass classToUseForJsConversion;
			convertAst: aMethod ast withPrimitive: aMethod primitive]

]

{ #category : #transpiling }
PjDependentTranspiler >> convertMethodAsts: aClass newClasses: newClasses [
	(convertedClasses includes: aClass) ifFalse: [
		aClass superclass ifNotNil: [self addClassToConvert: aClass superclass].
		self addClassesToConvert: 	(aClass theNonMetaClass sharedPools reject: #isJavascriptGlobalsPool).
		convertedClasses add: aClass.
		newClasses add: aClass
	].
	self withMethodsOf: aClass do: [: aMethod | self convertMethodAst: aMethod].
	self withMethodsOf: aClass class do: [: aMethod | self convertMethodAst: aMethod]

]

{ #category : #loading }
PjDependentTranspiler >> discoveredGlobalsPool: aClass [
	globalPools add: aClass
]

{ #category : #loading }
PjDependentTranspiler >> discoveredReferenceToClass: aClass [
	^ self addClassToConvert: aClass
]

{ #category : #transpiling }
PjDependentTranspiler >> generateCodeStringFrom: jsAst. [
	self convertAllClasses: #() writeDnu: true.
	generator asString: jsAst on: self jsStream.

]

{ #category : #transpiling }
PjDependentTranspiler >> importMethodsAll: aCollection forClass: aClass [
	| importMethods |
	importMethods := Dictionary new.
	aCollection do: [ : aSymbol |
		(aClass theNonMetaClass hasClassMethod: aSymbol) ifTrue: [
			(aClass theNonMetaClass perform: aSymbol) associationsDo: [ : assoc |
				importMethods at: assoc key ifPresent: [: im |
					im value addAll: assoc value
				 ] ifAbsent: [
					importMethods at: assoc key put: assoc value asSet
	]]]].
	^ importMethods
]

{ #category : #'initailize-release' }
PjDependentTranspiler >> initialize [
	super initialize.
	convertedMethods := IdentityDictionary new.
	classesToConvert := Set new.
	convertedClasses := Set new.
	alreadyDefinedClasses := Set new.
	alreadyInitializedClasses := Set new.
	alreadyInheritanceLinkedClasses := Set new.
	alreadyVariablesDeclaredClasses := Set new.
	globalPools := Set new.

]

{ #category : #invalidating }
PjDependentTranspiler >> invalidateClass: aClass [
	convertedClasses remove: aClass ifAbsent: [].
	self invalidateMethods: aClass classToUseForJsConversion theNonMetaClass methods.
	self invalidateMethods: aClass classToUseForJsConversion theMetaClass methods.

]

{ #category : #invalidating }
PjDependentTranspiler >> invalidateMethod: aMethod [
	convertedMethods removeKey: aMethod ifAbsent: [].

]

{ #category : #invalidating }
PjDependentTranspiler >> invalidateMethods: aCollection [
	aCollection do: [ : method | self invalidateMethod: method ]
]

{ #category : #statistics }
PjDependentTranspiler >> numberOfClasses [
	^ convertedClasses size
]

{ #category : #statistics }
PjDependentTranspiler >> numberOfMethods [
	^ convertedMethods size
]

{ #category : #transpiling }
PjDependentTranspiler >> transpileMethod: aMethod [
	| jsAst |
	jsAst := convertedMethods at: aMethod.
  	generator asString: jsAst on: self jsStream.
]

{ #category : #transpiling }
PjDependentTranspiler >> withMethodsOf: aClass do: aBlock [
	| nonOverriddenSelectors importMethods methodsToOutput |
	methodsToOutput := OrderedCollection new.
	super withMethodsOf: aClass do: [: method | methodsToOutput add: method].
	importMethods := self
		importMethodsAll: #(jsTranspilationImportMethods jsTranspilationImportMethodsNonstandard)
		forClass: aClass.
	importMethods keysAndValuesDo: [ : class : selectors |
		class isMeta = aClass isMeta ifTrue: [
			nonOverriddenSelectors := selectors copyWithoutAll: aClass selectors.
			nonOverriddenSelectors do: [ : aSymbol |
				methodsToOutput add: (class compiledMethodAt: aSymbol) ]]].
	methodsToOutput sort: [: l : r | l selector < r selector ].
	methodsToOutput do: aBlock.

]

{ #category : #transpiling }
PjDependentTranspiler >> writeClassAndPoolVariablesDeclarationOf: aClass [
	alreadyVariablesDeclaredClasses addIfNotPresent: aClass ifPresentDo: [ ^ self ].
	super writeClassAndPoolVariablesDeclarationOf: aClass.

]

{ #category : #transpiling }
PjDependentTranspiler >> writeClassDefinitionOf: aClass [
	alreadyDefinedClasses addIfNotPresent: aClass ifPresentDo: [ ^ self ].
	super writeClassDefinitionOf: aClass.

]

{ #category : #transpiling }
PjDependentTranspiler >> writeClassInheritanceLinksOf: aClass [
	alreadyInheritanceLinkedClasses addIfNotPresent: aClass ifPresentDo: [ ^ self ].
	super writeClassInheritanceLinksOf: aClass.

]

{ #category : #transpiling }
PjDependentTranspiler >> writeClassInitializeOf: aClass [
	alreadyInitializedClasses addIfNotPresent: aClass ifPresentDo: [ ^ self ].
	super writeClassInitializeOf: aClass.

]

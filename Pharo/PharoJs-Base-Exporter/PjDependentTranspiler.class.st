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
		'alreadyVariablesDeclaredClasses',
		'globalPools'
	],
	#category : #'PharoJs-Base-Exporter-Kernel'
}

{ #category : #accessing }
PjDependentTranspiler class >> lineEnding [
	^Character lf
]

{ #category : #accessing }
PjDependentTranspiler >> addAlreadyDefinedClasses: classes [

	alreadyDefinedClasses addAll: classes
]

{ #category : #transpiling }
PjDependentTranspiler >> addClassToConvert: aClass [

	| addClass |
	aClass javascriptIsExportableClass ifFalse: [ 
		^ converter transpilationError:
			  'non-exportable class ' , aClass name , ' referenced' ].
	addClass := aClass classToUseForJsConversion.
	(classesToConvert includes: addClass) ifFalse: [ " redundant test allows setting breakpoint for adding classes "
		addClass == PjTranspiler ifTrue: [ self halt ].
		addClass == Random ifTrue: [ self halt ].
		classesToConvert add: addClass ]
]

{ #category : #transpiling }
PjDependentTranspiler >> addClassesToConvert: classes [

	classes do: [ :aClass | self addClassToConvert: aClass ]
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
PjDependentTranspiler >> convertAllClasses: classes [

	| newClasses |
	self
		addClassesToConvert: (classes select: #javascriptIsExportableClass).
	newClasses := OrderedCollection new.
	[ classesToConvert isEmpty ]
		whileFalse: [ | theseClasses |
			theseClasses := classesToConvert.
			classesToConvert := Set new.
			theseClasses
				do:
					[ :aClass | self convertMethodAsts: aClass instanceSide newClasses: newClasses ] ].
	super convertAllClasses: newClasses
]

{ #category : #transpiling }
PjDependentTranspiler >> convertAndWriteClosedBlock: valuedBlock [

	self convertAndWriteClosedBlock: valuedBlock with: [
		self convertAllClasses: #() writeDnu: self shouldWriteDnu
	]
]

{ #category : #transpiling }
PjDependentTranspiler >> convertClass: aClass [

	self convertAllClasses: { aClass } writeDnu: self shouldWriteDnu
]

{ #category : #transpiling }
PjDependentTranspiler >> convertMethodAst: aMethod [
	(self shouldSkipMethodNode: aMethod) ifTrue: [ ^self ].
	convertedMethods at: aMethod name ifAbsentPut: [
		converter
			classForConversion: aMethod methodClass classToUseForJsConversion;
			convertAst: aMethod ast withPrimitive: aMethod primitive]
]

{ #category : #transpiling }
PjDependentTranspiler >> convertMethodAsts: aClass newClasses: newClasses [

	(convertedClasses includes: aClass)
		ifFalse: [ aClass superclass
				ifNotNil: [ self addClassToConvert: aClass superclass ].
			self
				addClassesToConvert: (aClass instanceSide sharedPools reject: #isJavascriptGlobalsPool).
			convertedClasses add: aClass.
			newClasses add: aClass ].
	self
		withMethodsOf: aClass
		do: [ :aMethod | self convertMethodAst: aMethod ].
	self
		withMethodsOf: aClass class
		do: [ :aMethod | self convertMethodAst: aMethod ]
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
PjDependentTranspiler >> generateCodeStringFrom: jsAst [

	self convertAllClasses: classesToConvert.
	super generateCodeStringFrom: jsAst
]

{ #category : #transpiling }
PjDependentTranspiler >> importMethodsAll: aCollection forClass: aClass [
	| importMethods |
	importMethods := Dictionary new.
	aCollection
		do: [ :aSymbol | 
			(aClass instanceSide hasClassMethod: aSymbol)
				ifTrue: [ (aClass instanceSide perform: aSymbol)
						associationsDo: [ :assoc | 
							importMethods
								at: assoc key
								ifPresent: [ :im | im value addAll: assoc value ]
								ifAbsent: [ importMethods at: assoc key put: assoc value asSet ] ] ] ].
	^ importMethods
]

{ #category : #initialization }
PjDependentTranspiler >> initialize [

	super initialize.
	convertedMethods := Dictionary new.
	classesToConvert := Set new.
	convertedClasses := Set new.
	alreadyDefinedClasses := Set new.
	alreadyInitializedClasses := Set new.
	alreadyVariablesDeclaredClasses := Set new.
	globalPools := Set new.
]

{ #category : #invalidating }
PjDependentTranspiler >> invalidateClass: aClass [

	convertedClasses remove: aClass ifAbsent: [  ].
	alreadyDefinedClasses remove: aClass ifAbsent: [  ].
	self invalidateMethods:
		aClass classToUseForJsConversion instanceSide methods.
	self invalidateMethods:
		aClass classToUseForJsConversion classSide methods
]

{ #category : #invalidating }
PjDependentTranspiler >> invalidateMethod: aMethod [

	convertedMethods removeKey: aMethod name ifAbsent: [].
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
	jsAst := convertedMethods at: aMethod name ifAbsent: [ 
		         Transcript crShow: 'Coult not find: ' , aMethod name.
		         Transcript crShow: 'In: '.
		         convertedMethods keys do: [ :method | 
			         Transcript crShow: method ].
		         Transcript crShow: 'End'.
		         convertedMethods errorKeyNotFound: aMethod ].
	generator asString: jsAst on: self jsStream
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
PjDependentTranspiler >> writeClassDefinitionOf: aClass [

	alreadyDefinedClasses addIfNotPresent: aClass ifPresentDo: [ ^ self ].
	super writeClassDefinitionOf: aClass
]

{ #category : #transpiling }
PjDependentTranspiler >> writeClassInitializeOf: aClass [

	alreadyInitializedClasses addIfNotPresent: aClass ifPresentDo: [ ^ self ].
	super writeClassInitializeOf: aClass
]

{ #category : #transpiling }
PjDependentTranspiler >> writeClassVariableDeclarationsOf: aClass [

	alreadyVariablesDeclaredClasses addIfNotPresent: aClass ifPresentDo: [ ^ self ].
	super writeClassVariableDeclarationsOf: aClass
]

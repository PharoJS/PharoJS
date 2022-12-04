"
I use PjTranspiler to export a PharoJs application to a stream.
"
Class {
	#name : #PjExporter,
	#superclass : #Object,
	#instVars : [
		'classes',
		'appClass',
		'fileName',
		'transpiler',
		'jsStream',
		'launchBlock',
		'launchArgs',
		'globalsPools'
	],
	#category : #'PharoJs-Base-Exporter-Kernel'
}

{ #category : #accessing }
PjExporter class >> bootstrapClasses [
	^ {Object. Boolean. Number. String. UndefinedObject. BlockClosure. Error. Array. Class}
]

{ #category : #accessing }
PjExporter class >> coreClass [
	^ self transpilerClass coreClass
]

{ #category : #'instance creation' }
PjExporter class >> newWithAppClass: aClass [
	^self new
		initializeWithAppClass: aClass;
		yourself
]

{ #category : #accessing }
PjExporter class >> transpilerClass [
	^ PjDependentTranspiler
]

{ #category : #'writing low-level' }
PjExporter >> << aString [

	jsStream << aString
]

{ #category : #adding }
PjExporter >> addAllClasses: someClasses [

	someClasses do: [ :each | self addClass: each ]
]

{ #category : #adding }
PjExporter >> addAllPackages: packageNames [

	packageNames do: [ :each | self addPackage: each ]
]

{ #category : #adding }
PjExporter >> addClass: aClass [

	(self isExportable: aClass) ifFalse: [ ^ self ].
	self classes add: aClass
]

{ #category : #adding }
PjExporter >> addPackage: packageName [

	self addAllClasses:
		(SystemOrganizer default classesInCategory: packageName asString)
]

{ #category : #accessing }
PjExporter >> appClass [

	^ appClass
]

{ #category : #accessing }
PjExporter >> bootstrapClasses [

	^ self class bootstrapClasses
]

{ #category : #accessing }
PjExporter >> classes [

	^ classes
]

{ #category : #loading }
PjExporter >> convertAllClassesToJs: someClasses [

	someClasses do: [ :aClass | self invalidateClass: aClass ].
	self addAllClasses: someClasses.
	^ self transpiler onTempStreamDo: [ 
		  self transpiler
			  convertAllClasses: self nonBootstrapClasses
			  writeDnu: true ]
]

{ #category : #writing }
PjExporter >> copyContentSelector [
	^#copyContent
]

{ #category : #accessing }
PjExporter >> coreClass [

	^ self class coreClass
]

{ #category : #'writing low-level' }
PjExporter >> cr [

	jsStream lf
]

{ #category : #writing }
PjExporter >> dnuHook [

	^ [ 
	  self writeGlobalsPolyfills: nil.
	  true ]
]

{ #category : #accessing }
PjExporter >> headerLine [

	^ self appClass headerLine
]

{ #category : #'initialize-release' }
PjExporter >> initialize [

	super initialize.
	classes := Set new.
	globalsPools := Set new.
	self transpiler: self transpilerClass new.
	self transpiler addAllOptionalConversions "Except: 0 to: 1/2".
	self setUpForPolyfill
]

{ #category : #accessing }
PjExporter >> initializeWithAppClass: aClass [

	appClass := aClass.
	transpiler pharoJsSelectorPrefix: aClass pharoJsSelectorPrefix.
	self addAllClasses: appClass appClasses.
	self addAllPackages: appClass appPackages
]

{ #category : #writing }
PjExporter >> installClassExtensionSelector [
	^self transpiler installClassExtensionSelector
]

{ #category : #testing }
PjExporter >> isExportable: aClass [

	aClass ifNil: [ ^ false ].
	aClass isTrait ifTrue: [ ^false ].
	aClass isTestCase ifTrue: [ ^false ].
	(aClass includesBehavior: TestResource) ifTrue: [ ^false ].
	^ true
]

{ #category : #'test support' }
PjExporter >> javascriptCode [

	^ String streamContents: [: aStream | self writeJsCodeOn: aStream]
]

{ #category : #'writing low-level' }
PjExporter >> jsStream: aStream do: aBlock [

	| savedStream |
	savedStream := jsStream.
	jsStream := aStream.
	[
		aBlock value
	] ensure: [ jsStream := savedStream ]
]

{ #category : #accessing }
PjExporter >> launchBlock [

	^ launchBlock ifNil: [ self appClass appLaunchBlock ]
]

{ #category : #accessing }
PjExporter >> launchBlock: aBlock [

	launchBlock := aBlock
]

{ #category : #'writing low-level' }
PjExporter >> nextPut: aCharacter [

	jsStream nextPut: aCharacter
]

{ #category : #'writing low-level' }
PjExporter >> nextPutAll: aString [

	jsStream nextPutAll: aString
]

{ #category : #writing }
PjExporter >> nonBootstrapClasses [

	| actualBootstrapClasses |
	actualBootstrapClasses := self bootstrapClasses asSet collect: #classToUseForJsConversion.
	^self classes reject: [ :setClass | 
			actualBootstrapClasses includes: setClass classToUseForJsConversion]
]

{ #category : #writing }
PjExporter >> pharoJsSelectorPrefix [

	^ self transpiler pharoJsSelectorPrefix
]

{ #category : #'initialize-release' }
PjExporter >> setUpForPolyfill [

	self transpiler beforeCodeOutputHook: [: pools | self writeGlobalsPolyfills: pools]
]

{ #category : #accessing }
PjExporter >> setupCode [

	^ self appClass setupCode
]

{ #category : #writing }
PjExporter >> space [
	jsStream space
]

{ #category : #accessing }
PjExporter >> transpiler [

	^ transpiler
]

{ #category : #accessing }
PjExporter >> transpiler: aTranspiler [

	transpiler := aTranspiler.
	transpiler onStream: self
]

{ #category : #accessing }
PjExporter >> transpilerClass [

	^ self class transpilerClass
]

{ #category : #writing }
PjExporter >> writeCore [

	self writeCoreObject.
	self writeCoreClass.
	self transpiler
		writeNameForClass: PjCore;
		<< '.theClassClass=';
		writeNameForClass: PjClassInJS;
		<< $;;
		cr;
		writeNameForClass: PjCore;
		<< $.;
		<< transpiler pharoJsSelectorPrefix;
		<< 'initializeCore();';
		cr
]

{ #category : #writing }
PjExporter >> writeCoreClass [

	self transpiler
		<< 'const ';
		writeNameForClass: PjClassInJS;
		<< '={prototype:function(){}};';
		cr;
		convertMethodAsts: PjClassInJS newClasses: Set new;
		writeClassDefinitionOf: PjClassInJS
]

{ #category : #writing }
PjExporter >> writeCoreObject [

	self writeCoreObjectCreation.
	self writeCoreObjectBasicMethods.
	self transpiler
		convertMethodAsts: PjCore newClasses: Set new;
		writeClassDefinitionOf: PjCore
]

{ #category : #writing }
PjExporter >> writeCoreObjectBasicMethods [

	self transpiler
		cr;
		<< 'global.';
		writeNameForClass: PjCore;
		<< $.;
		<< self pharoJsSelectorPrefix;
		<< 'require=global.require';
		cr;
		writeNameForClass: PjCore;
		<< $.;
		<< self copyContentSelector;
		<< '=function(source,target){
    let propertyNames = Object.getOwnPropertyNames(source).filter((each)=>
			/\b';
		<< self pharoJsSelectorPrefix;
		<< '/.test(each)
	  );
    propertyNames.forEach((name)=>target[name]=source[name]);
}';
		cr;
		writeNameForClass: PjCore;
		<< $.;
		<< self installClassExtensionSelector;
		<< '=function(extensionClass,targetClass){';
		cr;
		writeNameForClass: PjCore;
		<< $.;
		<< self copyContentSelector;
		<< '(extensionClass.prototype, targetClass.prototype);';
		cr;
		writeNameForClass: PjCore;
		<< $.;
		<< self copyContentSelector;
		<< '(extensionClass, targetClass);';
		cr;
		<< 'targetClass.';
		writeClassVarsPoolName;
		<< '=';
		<< 'targetClass.';
		writeClassVarsPoolName;
		<< '??{};';
		cr;
		<< 'Object.assign(targetClass.';
		writeClassVarsPoolName;
		<< ', extensionClass.';
		writeClassVarsPoolName;
		<< ');}';
		cr
]

{ #category : #writing }
PjExporter >> writeCoreObjectCreation [

	self transpiler
		<< 'global.';
		writeNameForClass: PjCore;
		<< '=global.';
		writeNameForClass: PjCore;
		<< '??{};'
]

{ #category : #writing }
PjExporter >> writeGlobalsPolyfills: pools [

	pools do: [ :pool | 
		self appClass
			polyfill: pool
			withTranspiler: self transpiler
			unlessIn: globalsPools ]
]

{ #category : #writing }
PjExporter >> writeJsCode [
		self writeJsCoreAndBootstrap.
		self writeNonBootstrapClasses.
		self writeLaunchCode
]

{ #category : #writing }
PjExporter >> writeJsCodeOn: aStream [

	self jsStream: aStream do: [ self writeJsCode ]
]

{ #category : #writing }
PjExporter >> writeJsCoreAndBootstrap [

	self nextPutAll: self setupCode; cr.
	self writeCore.
	self transpiler convertAllClasses: self bootstrapClasses writeDnu: false
]

{ #category : #writing }
PjExporter >> writeLaunchCode [

	self transpiler convertAndWriteClosedBlock: self launchBlock
]

{ #category : #writing }
PjExporter >> writeNonBootstrapClasses [

	self transpiler
		convertAllClasses: self nonBootstrapClasses
		writeDnu: true
]

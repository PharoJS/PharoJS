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
	"gather all classes from the package with name packageName. This includes definedClasses
	and extendedClasses. As there could be a Metaclass in the list we collect only the 
	instanceSide of Metaclass"
	self addAllClasses:
		((RPackage organizer packageNamed: packageName) classes collect: #instanceSide) asSet
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
PjExporter >> copyMethodsSelector [

	^ #copyMethods
]

{ #category : #accessing }
PjExporter >> coreClass [

	^ self class coreClass
]

{ #category : #'writing low-level' }
PjExporter >> cr [

	jsStream lf
]

{ #category : #'writing low-level' }
PjExporter >> crtab [

	jsStream cr; tab
]

{ #category : #writing }
PjExporter >> dnuHook [

	^ [ 
	  self writeGlobalsPolyfills: nil.
	  true ]
]

{ #category : #'writing core' }
PjExporter >> fixInheritanceLinkOfMethodDefinition [
	^'function(aClass) {
    if (!aClass.hasOwnProperty("subclasses")) {
        aClass.subclasses = [];
    }
    let currentSuperclass;
    if (aClass == Object) {
        currentSuperclass = undefined;
    } else {
        currentSuperclass = aClass.__proto__;
    }
    if (currentSuperclass == undefined) { return this; }
    if (!currentSuperclass.hasOwnProperty("subclasses")) {
        return currentSuperclass.subclasses = [aClass];
    }
    if (currentSuperclass.subclasses.includes(aClass)) { return; }
    currentSuperclass.subclasses.push(aClass);
}'
]

{ #category : #'writing core' }
PjExporter >> fixInheritanceLinkOfSelector [

	^ #fixInheritanceLinkOf
]

{ #category : #'writing core' }
PjExporter >> fixMetaclassOfMethodDefinition [
	^'function(aClass)
{
  if (aClass === this) { return this; }
  if (aClass === Object) {
    return Object.setPrototypeOf(aClass, PjClass.prototype);
  }
  if (Object.getPrototypeOf(aClass) === Function.prototype){ 
    return Object.setPrototypeOf(aClass, Object);
  }
}'
]

{ #category : #'writing core' }
PjExporter >> fixMetaclassOfSelector [

	^ #fixMetaclassOf
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
PjExporter >> installAllAliasesSelector [
	^PjTranspiler installAllAliasesSelector
]

{ #category : #'writing core' }
PjExporter >> installClassSelector [
	^self transpiler installClassSelector
]

{ #category : #writing }
PjExporter >> installJsClassPlaceholderSelector [
	^self transpiler installJsClassPlaceholderSelector
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

{ #category : #'writing core' }
PjExporter >> writeCore [

	self writeCoreObject.
	self writeCoreClass.
	self transpiler
		writeNameForClass: PjCore;
		<< '.theClassClass=';
		writeNameForClass: PjClass;
		<< $;;
		cr;
		writeNameForClass: PjCore;
		<< $.;
		<< transpiler pharoJsSelectorPrefix;
		<< 'initializeCore();';
		cr
]

{ #category : #'writing core' }
PjExporter >> writeCoreClass [

	self transpiler
		convertMethodAsts: PjClass newClasses: Set new;
		writeClassDefinitionOf: PjClass
]

{ #category : #'writing core' }
PjExporter >> writeCoreObject [

	self writeCoreObjectCreation.
	self writeCoreObjectBasicMethods.
	self transpiler
		convertMethodAsts: PjCore newClasses: Set new;
		writeClassDefinitionOf: PjCore
]

{ #category : #'writing core' }
PjExporter >> writeCoreObjectBasicMethods [

	self
		writeCoreObjectCopyMethods;
		writeFixMetaclassOfMethod;
		writeFixInheritanceLinkOfMethod;
		writeCoreObjectInstallClassMethod;
		writeCoreObjectInstallClassExtensionMethod;
		writeCoreObjectInstallAliasesMethods
]

{ #category : #'writing core' }
PjExporter >> writeCoreObjectCopyMethods [

	self transpiler
		cr;
		writeNameForClass: PjCore;
		<< $.;
		<< self copyMethodsSelector;
		<< '=function(source,target){
    let propertyNames = Object.getOwnPropertyNames(source).filter((each)=>
			/\b';
		<< self pharoJsSelectorPrefix;
		<< '/.test(each)
	  ); 
    propertyNames.forEach('.
	self writePropertyDefinitionFunctionFrom: 'source' to: 'target'.
	self transpiler
		<< ');
}';
		cr
]

{ #category : #'writing core' }
PjExporter >> writeCoreObjectCreation [

	self transpiler
		<< 'global.';
		writeNameForClass: PjCore;
		<< '=global.';
		writeNameForClass: PjCore;
		<< '??class extends Object{};'
]

{ #category : #'writing core' }
PjExporter >> writeCoreObjectInstallAliasesMethods [

	| coreClassName |
	coreClassName := PjCore instanceSide nameToUseForJsConversion.
	self transpiler
		<< coreClassName;
		<<
			'.installSelectorAliases=function(aliases, selector, target){
		aliases.forEach('.
	self
		writePropertyDefinitionFunctionFrom: 'target'
		at: 'selector'
		to: 'target'.
	self transpiler
		<< ');
	}';
		cr;
		<< coreClassName;
		<< '.installAliasesFromDict=function(aliasesDict, target){
		for(let key of Object.getOwnPropertyNames(aliasesDict)){';
		<< coreClassName;
		<< '.installSelectorAliases(aliasesDict[key], key, target);
	}}';
		cr;
		<< coreClassName;
		<< $.;
		<< self installAllAliasesSelector;
		<<
			'=function(instanceSideAliasesDict, classSideAliasesDict, targetClass){';
		cr;
		<< coreClassName;
		<<
			'.installAliasesFromDict(instanceSideAliasesDict, targetClass.prototype);';
		cr;
		<< coreClassName;
		<< '.installAliasesFromDict(classSideAliasesDict, targetClass);
	}';
		cr
]

{ #category : #'writing core' }
PjExporter >> writeCoreObjectInstallClassExtensionMethod [

	self transpiler
		writeNameForClass: PjCore;
		<< $.;
		<< self installJsClassPlaceholderSelector;
		<<
			'=function(extensionClass,targetClass,instanceSideAliasesDict,classSideAliasesDict){';
		crtab;
		<< 'this.';
		<< self copyMethodsSelector;
		<< '(extensionClass.prototype, targetClass.prototype);';
		crtab;
		<< 'this.';
		<< self copyMethodsSelector;
		<< '(extensionClass, targetClass);';
		crtab;
		<< 'targetClass.';
		writeClassVarsPoolName;
		<< '=';
		<< 'targetClass.';
		writeClassVarsPoolName;
		<< '??{};';
		crtab;
		<< 'Object.assign(targetClass.';
		writeClassVarsPoolName;
		<< ', extensionClass.';
		writeClassVarsPoolName;
		<< ');';
		crtab;
		<< 'this.';
		<< self installAllAliasesSelector;
		<<
			'(instanceSideAliasesDict, classSideAliasesDict, targetClass);';
		crtab;
		<< 'this.';
		<< self fixMetaclassOfSelector;
		<< '(targetClass);';
		crtab;
		<< 'this.';
		<< self fixInheritanceLinkOfSelector;
		<< '(targetClass);';
		crtab;
		<< 'this[targetClass.name]=targetClass;';
		crtab;
		<< 'global[targetClass.name]=targetClass;';
		cr;
		<< $};
		cr
]

{ #category : #'writing core' }
PjExporter >> writeCoreObjectInstallClassMethod [

	self transpiler
		writeNameForClass: PjCore;
		<< $.;
		<< self installClassSelector;
		<<
			'=function(newClass,instanceSideAliasesDict,classSideAliasesDict){';
		crtab;
		<< 'this.';
		<< self installAllAliasesSelector;
		<<
			'(instanceSideAliasesDict, classSideAliasesDict, newClass, newClass);';
		crtab;
		<< 'this.';
		<< self fixMetaclassOfSelector;
		<< '(newClass);';
		crtab;
		<< 'this.';
		<< self fixInheritanceLinkOfSelector;
		<< '(newClass);';
		crtab;
		<< 'this[newClass.name]=newClass;';
		crtab;
		<< 'global[newClass.name]=newClass;';
		cr;
		<< $};
		cr
]

{ #category : #'writing core' }
PjExporter >> writeFixInheritanceLinkOfMethod [

	self transpiler
		writeNameForClass: PjCore;
		<< $.;
		<< self fixInheritanceLinkOfSelector;
		<< $=;
		<< self fixInheritanceLinkOfMethodDefinition;
		<< $; ;
		cr
]

{ #category : #'writing core' }
PjExporter >> writeFixMetaclassOfMethod [

	self transpiler
		writeNameForClass: PjCore;
		<< $.;
		<< self fixMetaclassOfSelector;
		<< $=;
		<< self fixMetaclassOfMethodDefinition;
		<< $; ;
		cr
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

{ #category : #'writing core' }
PjExporter >> writePropertyDefinitionFunctionFrom: sourceString at: sourceSelector to: targetString [

	self
		writePropertyDefinitionFunctionFrom: sourceString
		at: sourceSelector 
		to: targetString
		at: 'name'
]

{ #category : #'writing core' }
PjExporter >> writePropertyDefinitionFunctionFrom: sourceString at: sourceSelector to: targetString at: targetSelector [

	self transpiler
		<< '(';
		<< targetSelector;
		<< ')=>Object.defineProperty(';
		<< targetString;
		<< ',';
		<< targetSelector;
		<< ',{value:';
		<< sourceString;
		<< '[';
		<< sourceSelector;
		<< '],configurable:true})'
]

{ #category : #'writing core' }
PjExporter >> writePropertyDefinitionFunctionFrom: sourceString to: targetString [

	self writePropertyDefinitionFunctionFrom: sourceString at: 'name' to: targetString at: 'name'
]

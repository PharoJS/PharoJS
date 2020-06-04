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
	#category : #'PharoJsExporter-Kernel'
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
PjExporter class >> exporterForApp: aClass [
	^self new
		appClass: aClass;
		yourself
]

{ #category : #accessing }
PjExporter class >> transpilerClass [
	^ PjDependentTranspiler
]

{ #category : #adding }
PjExporter >> addAllClasses: someClasses [ 
	someClasses do: [: each | self addClass: each]
]

{ #category : #adding }
PjExporter >> addAllPackages: packageNames [ 
	packageNames do: [ : each |
		self addPackage: each ]
]

{ #category : #adding }
PjExporter >> addClass: aClass [
	(self isExportable: aClass) ifFalse: [ ^self ].
	self classes add: aClass
]

{ #category : #adding }
PjExporter >> addPackage: packageName [
	self
		addAllClasses: (SystemOrganizer default classesInCategory: packageName asString)
]

{ #category : #accessing }
PjExporter >> appClass [
	^appClass.
]

{ #category : #accessing }
PjExporter >> appClass: aClass [ 
	appClass := aClass.
	transpiler pharoJsSelectorPrefix: aClass pharoJsSelectorPrefix.
	self addAllClasses: appClass appClasses.
	self addAllPackages: appClass appPackages.

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
	someClasses do: [ : aClass | self invalidateClass: aClass]. 
	self addAllClasses: someClasses.
	^ self transpiler onTempStreamDo: [
		self transpiler convertAllClasses: self nonBootstrapClasses writeDnu: true].
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
	^ [ self writeGlobalsPolyfills: nil.
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
	self transpiler addAllOptionalConversions"Except: 0 to: 1/2".
	self setUpForPolyfill.

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

{ #category : #'initialize-release' }
PjExporter >> setUpForPolyfill [
	self transpiler beforeCodeOutputHook: [: pools | self writeGlobalsPolyfills: pools]

]

{ #category : #accessing }
PjExporter >> setupCode [
	^self appClass setupCode 
]

{ #category : #accessing }
PjExporter >> transpiler [
	^transpiler
]

{ #category : #accessing }
PjExporter >> transpiler: aTranspiler [
	transpiler := aTranspiler.
	transpiler onStream: self
]

{ #category : #accessing }
PjExporter >> transpilerClass [
	^self class transpilerClass
]

{ #category : #writing }
PjExporter >> writeCoreObject [
	| coreName |
	coreName := self coreClass nameToUseForJsConversion.
	self transpiler
		nextPutAll: 'global.';
		nextPutAll: coreName;
		nextPutAll: '=global.';
		nextPutAll: coreName;
		nextPutAll: '||(function ';
		nextPutAll: coreName;
		nextPutAll: '(){});';cr;
		nextPutAll: 'Object.defineProperty(Object.prototype,"$def",{value:';cr;
		nextPutAll: ' function $def(aFunc){';cr;
		nextPutAll: '	Object.defineProperty(this,aFunc.name,{writable:true,value:aFunc})}})';cr;
		nextPutAll: 'Object.defineProperty(Object.prototype,"$$def",{value:';cr;
		nextPutAll: ' function $$def(){';cr;
		nextPutAll:	'   var v=Array.from(arguments),f=v[0];';cr;
		nextPutAll: '   v[0]=this';cr;
		nextPutAll: '	  v=Array.from(v,function(x){if(!x.classPool)x.classPool={};return x.classPool})';cr;
		nextPutAll: '   v.unshift(this.$def.bind(this.prototype),this.$def.bind(this.__proto__));';cr;
		nextPutAll: '   f.apply(null,v)}})';cr;
		nextPutAll: 'var require';cr;
		nextPutAll: 'global.';
		nextPutAll: coreName;
		nextPutAll: '.require=require';cr;
		writeClassDefinitionOf: PjClass;
		nextPutAll: coreName;
		nextPutAll: '.theClassClass=';
		writeNameForClass: PjClass;
		nextPut: $;;cr;
		nextPutAll: coreName;
		nextPutAll: '.$$def(function(i$,c$){';cr;
		convertMethodAsts: self coreClass classToUseForJsConversion newClasses: OrderedCollection new;
		writeMethodsOf: self coreClass class named: coreName with: 'c$' ;
		nextPutAll: '})';cr;
		nextPutAll: coreName;
		nextPut: $.;
		nextPutAll: transpiler pharoJsSelectorPrefix;
		nextPutAll: 'initializeCore();';cr
]

{ #category : #writing }
PjExporter >> writeGlobalsPolyfills: pools [
	pools do: [ :pool | 
		self appClass
			polyfill: pool
			withTranspiler: self transpiler
			unlessIn: globalsPools
	].

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
	self writeCoreObject.
	self transpiler convertAllClasses: self bootstrapClasses writeDnu: false
]

{ #category : #writing }
PjExporter >> writeLaunchCode [
	self transpiler convertAndWriteClosedBlock: self launchBlock.

]

{ #category : #writing }
PjExporter >> writeNonBootstrapClasses [
	self transpiler
		convertAllClasses: self nonBootstrapClasses
		writeDnu: true
]

Class {
	#name : #PjExporterTest,
	#superclass : #TestCase,
	#traits : 'PjTJavascriptCodeAnalyser',
	#classTraits : 'PjTJavascriptCodeAnalyser classTrait',
	#instVars : [
		'exporter',
		'jsCode'
	],
	#category : #'PharoJs-Base-Exporter-Tests-Tests'
}

{ #category : #running }
PjExporterTest >> classToTranspile [
	^ PjClassExtensionForTest
]

{ #category : #accessing }
PjExporterTest >> jsCode [
	^jsCode
]

{ #category : #accessing }
PjExporterTest >> lineEnding [
	^exporter transpiler lineEnding
]

{ #category : #accessing }
PjExporterTest >> pharoJsSelectorPrefix [
	^ exporter transpiler pharoJsSelectorPrefix
]

{ #category : #running }
PjExporterTest >> setUp [
	super setUp.
	exporter := PjExporter new.
]

{ #category : #testing }
PjExporterTest >> testAvoidOverridingOnImportMethodsFromPharo [

	exporter initializeWithAppClass: PjApplication.
	exporter addClass: PjClassExtensionForTest.
	jsCode := exporter javascriptCode.
	self assertInstanceMethod: #foo equals: '(){return 42}'.
	self
		assert: (jsCode splitOn:
				 self pharoJsSelectorPrefix , 'foo') size
		equals: 2
]

{ #category : #testing }
PjExporterTest >> testClassInheritanceOrder [

	exporter initializeWithAppClass: PjDOMApplication.
	jsCode := exporter javascriptCode.
	self assert: 'class PjApplication' precedes: 'class PjDOMApplication'
]

{ #category : #testing }
PjExporterTest >> testCoreClassedLoaded [

	| pjPrefix |
	exporter initializeWithAppClass: PjApplication.
	pjPrefix := self pharoJsSelectorPrefix. " has to be done after an application has been set "
	jsCode := exporter javascriptCode.
	self assert: (jsCode includesSubstring:
			 'installClass(class PjClass extends Function{').
	self assert: (jsCode includesSubstring:
			 'installClass(class PjApplication extends Object{').
	self deny: (jsCode includesSubstring: 'class Object').
	self assert: (jsCode includes: 'PjClass' before: 'PjApplication').
	self assert: (jsCode
			 includes: PjTranspiler installClassSelector , '=function('
			 before: 'PjApplication').
	self assert: (jsCode
			 includes:
			 PjTranspiler installClassExtensionSelector , '=function('
			 before: 'PjApplication')
]

{ #category : #testing }
PjExporterTest >> testExportingClassesAndPackages [
	exporter addClass: Object.
	self assert: exporter classes size equals: 1.
	exporter addAllClasses: {String. Array}.
	self assert: exporter classes size equals: 3.
	exporter addPackage: 'PharoJs-Base-Exporter-Tests-Support'.
	self assert: exporter classes size = 8.
	exporter addAllPackages: {PjExporter category.  PjTranspiler category}.
	self assert: exporter classes size > 10.
]

{ #category : #testing }
PjExporterTest >> testImportMethodsFromPharo [
	exporter initializeWithAppClass: PjApplication.
	exporter addClass: PjClassExtensionForTest.
	jsCode := exporter javascriptCode.
	#(yourself isArray isLiteral eqv:) do: [ : selector |
		self assertHasInstanceMethod: selector ].
	#(allInstances allInstancesDo: new) do: [ : selector |
		self assertHasClassMethod: selector ].
	self assertInstanceMethod: #yourself equals: '(){return this}'
]

{ #category : #testing }
PjExporterTest >> testJsSelector [
	| contents |
	contents := (PjTestFileExporter exportApp: PjTestClassForPolyfill) contents.
	self assert: (contents includesSubstring: 'alt_m(').
]

{ #category : #testing }
PjExporterTest >> testLaunchCodeAppearsAtTheEndOfExportedCode [
	exporter initializeWithAppClass: PjApplication.
	exporter launchBlock: [42].
	jsCode := exporter javascriptCode.
	self assert: (jsCode allButLast endsWith: 'return 42})();')
]

{ #category : #testing }
PjExporterTest >> testMainClassIsAddedToClassesToExport [
	exporter initializeWithAppClass: PjWebApplication.
	self assert: (exporter classes includes: PjWebApplication).
	self assert: exporter classes size > 1.
]

{ #category : #testing }
PjExporterTest >> testPolyfills [
	| contents foobar bar |
	contents := (PjTestFileExporter exportApp: PjMinimalNodeApplication) contents.
	self deny: (contents includesSubstring: ' WebSocket=Smalltalk.require("ws")').
	contents := (PjTestFileExporter exportApp: PjTestClassForPolyfill) contents.
	self assert: (contents includesSubstring: ' WebSocket=Smalltalk.require("ws")').
	self assert: (contents includesSubstring: ' Foobar=Smalltalk.require("foobar")').
	self assert: (contents includesSubstring: 'Bar=Foobar.Bar').
	foobar := contents findString: ' Foobar=Smalltalk.require("foobar")'.
	bar := contents findString: 'Bar=Foobar.Bar'.
	self assert: foobar<bar.
]

{ #category : #testing }
PjExporterTest >> testTestResourcesAreIgnored [
	exporter addAllClasses: {TestResource}.
	self assert: exporter classes isEmpty.
]

{ #category : #testing }
PjExporterTest >> testTestsAreIgnored [
	exporter addAllClasses: {TestCase. PjExporterTest}.
	self assert: exporter classes isEmpty.
]

{ #category : #testing }
PjExporterTest >> testTraitsAreIgnored [
	exporter addClass: TComparable.
	self assert: exporter classes isEmpty.
]

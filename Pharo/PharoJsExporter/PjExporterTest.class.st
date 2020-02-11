Class {
	#name : #PjExporterTest,
	#superclass : #TestCase,
	#traits : 'PjTJavascriptCodeAnalyser',
	#classTraits : 'PjTJavascriptCodeAnalyser classTrait',
	#instVars : [
		'exporter',
		'jsCode'
	],
	#category : #'PharoJsExporter-Tests'
}

{ #category : #accessing }
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

{ #category : #'as yet unclassified' }
PjExporterTest >> selectorsPrefix [
	^ exporter transpiler pharoJsSelectorPrefix
]

{ #category : #running }
PjExporterTest >> setUp [
	super setUp.
	exporter := PjExporter new.

]

{ #category : #testing }
PjExporterTest >> testAvoidOverridingOnImportMethodsFromPharo [
	exporter appClass: PjApplication.
	exporter addClass: PjClassExtensionForTest.
	jsCode := exporter javascriptCode.
	self assertInstanceMethod: #isLiteral equals: '(){return 42}'.
	self assert: (jsCode splitOn: 'i$(function ', exporter transpiler pharoJsSelectorPrefix,'isLiteral') size equals: 2.

]

{ #category : #testing }
PjExporterTest >> testClassInheritanceOrder [
	exporter appClass: PjApplication.
	jsCode := exporter javascriptCode.
	self assert: 'Object.', exporter transpiler pharoJsSelectorPrefix, 'subclass_(Error)' precedes: 'Error.', exporter transpiler pharoJsSelectorPrefix, 'subclass_'
]

{ #category : #testing }
PjExporterTest >> testCoreClassedLoaded [
	|pjPrefix|
	pjPrefix := exporter transpiler pharoJsSelectorPrefix.
	exporter appClass: PjApplication.
	jsCode := exporter javascriptCode.
	self assert: (jsCode includesSubstring: 'Object.', pjPrefix, 'subclass_("PjApplication")' ).
	self deny: (jsCode includesSubstring: 'function Object()' ).
	self assert: (jsCode includes: 'c$(function ', pjPrefix, 'new' before: 'PjApplication' ).
	self deny: (jsCode includes: 'PjApplication' before: 'c$(function ',pjPrefix,'new' ).

]

{ #category : #testing }
PjExporterTest >> testExportingClassesAndPackages [
	exporter addClass: Object.
	self assert: exporter classes size equals: 1.
	exporter addAllClasses: {String. Array}.
	self assert: exporter classes size equals: 3.
	exporter addPackage: 'PharoJsExporter-Tests-Support'.
	self assert: exporter classes size = 7.
	exporter addAllPackages: {PjExporter category.  PjTranspiler category}.
	self assert: exporter classes size > 10.

]

{ #category : #testing }
PjExporterTest >> testImportMethodsFromPharo [
	exporter appClass: PjApplication.
	exporter addClass: PjClassExtensionForTest.
	jsCode := exporter javascriptCode.
	#(yourself isArray isLiteral eqv:) do: [ : selector |
		self assertHasInstanceMethod: selector ].
	#(allInstances allInstancesDo: new) do: [ : selector |
		self assertHasClassMethod: selector ].
	self assertInstanceMethod: #yourself equals: '(){return this}'
]

{ #category : #testing }
PjExporterTest >> testLaunchCodeAppearsAtTheEndOfExportedCode [
	exporter appClass: PjApplication.
	exporter launchBlock: [42].
	jsCode := exporter javascriptCode.
	self assert: (jsCode allButLast endsWith: 'return 42})();')
]

{ #category : #testing }
PjExporterTest >> testMainClassIsAddedToClassesToExport [
	exporter appClass: PjWebApplication.
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

{ #category : #writing }
PjExporterTest >> writeJsSelector: aSelector onStream: aStream [
	| isBinary |
	(aSelector beginsWith: self jsNativePrefix) ifTrue: [ 
			^ aStream nextPutAll: ((aSelector keywords first allButFirst: self jsNativePrefix size) copyWithout: $:) ].
	isBinary := aSelector isBinary.
	aStream nextPutAll: self pharoJsSelectorPrefix.
	aSelector do:[ :each | 
			self writeSelectorChar: each on: aStream isInBinarySelector: isBinary ]
]

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
	self assert: (jsCode splitOn: 'prototype._isLiteral = ') size equals: 2.
]

{ #category : #testing }
PjExporterTest >> testCoreClassedLoaded [
	| jsCode |
	exporter appClass: PjApplication.
	jsCode := exporter javascriptCode.
	self assert: (jsCode includesSubstring: 'function PjApplication(){}' ).
	self deny: (jsCode includesSubstring: 'function Object()' ).
	self assert: (jsCode includes: 'Object.__proto__._new =' before: 'PjApplication' ).
	self deny: (jsCode includes: 'PjApplication' before: 'Object.__proto__._new =' ).

]

{ #category : #testing }
PjExporterTest >> testExportingClassesAndPackages [
	exporter addClass: Object.
	self assert: exporter classes size equals: 1.
	exporter addAllClasses: {String. Array}.
	self assert: exporter classes size equals: 3.
	exporter addPackage: 'PharoJsExporter-Tests-Support'.
	self assert: exporter classes size = 4.
	exporter addAllPackages: {PjExporter category.  PjTranspiler category}.
	self assert: exporter classes size > 10.

]

{ #category : #testing }
PjExporterTest >> testImportMethodsFromPharo [
	exporter appClass: PjApplication.
	exporter addClass: PjClassExtensionForTest.
	jsCode := exporter javascriptCode.
	#(yourself name isLiteral eqv:) do: [ : selector |
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
	exporter appClass: PjBrowserApplication.
	self assert: (exporter classes includes: PjBrowserApplication).
	self assert: exporter classes size > 1.

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

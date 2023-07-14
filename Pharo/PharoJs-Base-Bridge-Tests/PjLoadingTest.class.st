Class {
	#name : #PjLoadingTest,
	#superclass : #PjBridgeTestCase,
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #tests }
PjLoadingTest >> testEvalBlock [
	PjLoadForTest reset.
	self bridge evalBlock: [ window js_at: #valueForEvalTest put: 42 ].
	self
		assert: (self bridge evalBlock: [ window js_at: #valueForEvalTest ])
		equals: 42.
	self
		should: [ self bridge evalBlock: [ window aMethodThatDoesntExist ] ]
		raise: PjJavascriptError.
	self
		assert: (self bridge evalBlock: [ PjLoadForTest fortyTwo ])
		equals: PjLoadForTest fortyTwo.
	self
		assert: (self bridge evalBlock: [ PjLoadForTest new subtract: 25 ])
		equals: (PjLoadForTest new subtract: 25).
	self
		assert: (self bridge evalBlock: [ PjLoadForTest new seventeen ])
		equals: PjLoadForTest new seventeen.
	self
		assert: (self bridge evalBlock: [ PjLoadForTest y ])
		equals: PjLoadForTest y.
	self
		assert: (self bridge evalBlock: [ PjLoadForTest new z ])
		equals: PjLoadForTest new z.
	self
		assert: (self bridge evalBlock: [ PjLoadForTest classVarNames size ])
		equals: PjLoadForTest classVarNames size.
	self
		bridge evalBlock: [ PjLoadForTest setupClassVars ].
	self
		assert: (self bridge evalBlock: [ PjLoadForTest y ])
		equals: 'Y value'.
	self
		assert: (self bridge evalBlock: [ PjLoadForTest new z ])
		equals: 'Z value'.
]

{ #category : #tests }
PjLoadingTest >> testLiteralGeneration [

	self assertEquivalent: [ PjLoadForTest literal ].
	self assertEquivalent: [ PjLoadForTest new literal ]
]

{ #category : #tests }
PjLoadingTest >> testLoadClass [

	PjLoadForTest reset.
	self bridge loadClass: PjLoadForTest.
	self
		assert: (self bridge evalBlock: [ PjLoadForTest fortyTwo ])
		equals: PjLoadForTest fortyTwo.
	self
		assert: (self bridge evalBlock: [ PjLoadForTest new subtract: 25 ])
		equals: (PjLoadForTest new subtract: 25).
	self
		assert: (self bridge evalBlock: [ PjLoadForTest new seventeen ])
		equals: PjLoadForTest new seventeen
]

{ #category : #tests }
PjLoadingTest >> testLoadClassContents [

	| first firstBlock second secondBlock className third pjPrefix|
	pjPrefix := self bridge exporter transpiler pharoJsSelectorPrefix.
	className := PjLoadForTest nameToUseForJsConversion.
	PjLoadForTest reset.
	first := self bridge convertToJs: PjLoadForTest.
	self assert: (first beginsWith: 'Smalltalk.installClass(class ', className,' extends Object' ).
	self assert: (first trim endsWith: className , '.', pjPrefix, 'initialize();').
	firstBlock := self bridge
		convertToJs: [ PjLoadForTest fortyTwo ] asValuedBlock.
	self assert: ('*registerDnuForAll*' match: firstBlock).
	secondBlock := self bridge
		convertToJs: [ PjLoadForTest fortyTwo ] asValuedBlock.
	self deny: ('*registerDnuForAll*' match: secondBlock).
	second := self bridge convertToJs: PjLoadForTest.
	self assert: second equals: ''.
	self bridge exporter invalidateClass: PjLoadForTest.
	third := self bridge convertToJs: PjLoadForTest.
	self deny: third = ''.
	self deny: (third beginsWith: 'function ' , className).
	self deny: (third endsWith: className , '.', pjPrefix, 'initialize();')
]

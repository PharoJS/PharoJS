Class {
	#name : #PjLoadingTest,
	#superclass : #PjBridgeTestCase,
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsBridgeTest-Tests'
}

{ #category : #testing }
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
		equals: PjLoadForTest new seventeen
]

{ #category : #testing }
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

{ #category : #testing }
PjLoadingTest >> testLoadClassContents [
	| first firstBlock second secondBlock className third |
	className := PjLoadForTest nameToUseForJsConversion.
	PjLoadForTest reset.
	first := self bridge convertToJs: PjLoadForTest.
	self assert: (first beginsWith: 'function ' , className).
	self assert: (first trim endsWith: className , '.', PjTranspiler pharoJsSelectorPrefix, 'initialize();').
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
	self deny: (third endsWith: className , '.', PjTranspiler pharoJsSelectorPrefix, 'initialize();')
]

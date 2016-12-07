Class {
	#name : #PjLoadingTest,
	#superclass : #PjBridgeTestCase,
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsBridge-Tests'
}

{ #category : #testing }
PjLoadingTest >> testEvalBlock [
	PjLoadForTest reset.
	bridge evalBlock: [ window js_at: #valueForEvalTest put: 42 ].
	self assert: (bridge evalBlock: [ window js_at: #valueForEvalTest ]) equals: 42.
	self should: [bridge evalBlock: [ window aMethodThatDoesntExist ]] raise: PjJavascriptError.
	self assert: (bridge evalBlock: [ PjLoadForTest fortyTwo ]) equals: PjLoadForTest fortyTwo.
	self assert: (bridge evalBlock: [ PjLoadForTest new subtract: 25 ]) equals: (PjLoadForTest new subtract: 25).
	self assert: (bridge evalBlock: [ PjLoadForTest new seventeen ]) equals: PjLoadForTest new seventeen.

]

{ #category : #testing }
PjLoadingTest >> testLoadClass [
	PjLoadForTest reset.
	bridge loadClass: PjLoadForTest.
	self assert: (bridge evalBlock: [ PjLoadForTest fortyTwo ]) equals: PjLoadForTest fortyTwo.
	self assert: (bridge evalBlock: [ PjLoadForTest new subtract: 25 ]) equals: (PjLoadForTest new subtract: 25).
	self assert: (bridge evalBlock: [ PjLoadForTest new seventeen ]) equals: PjLoadForTest new seventeen.

]

{ #category : #testing }
PjLoadingTest >> testLoadClassContents [
	| first firstBlock second secondBlock className third |
	className := PjLoadForTest nameToUseForJsConversion.
	PjLoadForTest reset.

	first := bridge convertToJs: PjLoadForTest.
	self assert: (first beginsWith: 'function ',className).
	self assert: (first trim endsWith: className,'._initialize();').

	firstBlock := bridge convertToJs: [ PjLoadForTest fortyTwo ] asValuedBlock.
	self assert: ('*registerDnuForAll*' match: firstBlock).
	secondBlock := bridge convertToJs: [ PjLoadForTest fortyTwo ] asValuedBlock.
	self deny: ('*registerDnuForAll*' match: secondBlock).

	second := bridge convertToJs: PjLoadForTest.
	self assert: second equals: ''.

	bridge exporter invalidateClass: PjLoadForTest.
	third := bridge convertToJs: PjLoadForTest.
	self deny: third = ''.
	self deny: (third beginsWith: 'function ',className).
	self deny: (third endsWith: className,'._initialize();').

]

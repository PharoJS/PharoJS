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
PjLoadingTest >> testLoad2ExtensionsOfTheSameClassWithSameSuperclassAndOverrides [
	| extension1 extension2 |
	extension1 := classFactory newClass.
	{'instMethod1
	^true'.
	'instMethod2
	^200'} do: [: methodString | extension1 compile: methodString].
	{'classMethod1
	^true'.
	'classMethod2
	^200'.
	'javascriptName
	<pharoJsSkip>
	^#Number'
	} do: [: methodString | extension1 class compile: methodString].
	extension2 := classFactory newClass.
	{'instMethod1
	^false'.
	'instMethod3
	^300'} do: [: methodString | extension2 compile: methodString].
	{'classMethod1
	^false'.
	'classMethod3
	^300'.
	'javascriptName
	<pharoJsSkip>
	^#Number'} do: [: methodString | extension2 class compile: methodString].	
	bridge loadAllClasses: {extension1. extension2}.
	self assert: [ 1 instMethod1 ] evaluatesTo: false. "Overriden instance method"
	self assert: [ Number classMethod1 ] evaluatesTo: false.  "Overriden class method"
	self assert: [ 100 instMethod2 ] evaluatesTo: 200. "instance method from extension 1"
	self assert: [ Number classMethod2 ] evaluatesTo: 200.  "class method from extension 1"
	self assert: [ 3.14 instMethod3 ] evaluatesTo: 300. "instance method from extension 2"
	self assert: [ Number classMethod3 ] evaluatesTo: 300.  "class method from extension 2"

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

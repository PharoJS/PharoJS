"
Start the browser with a minimal web page, then if debugging, give a version with a debugging log of the WebSocket traffic.

Note that closing a web page doesn't work under Firefox unless you go, in the browser, to: 
	about:config
and change the field
	dom.allow_scripts_to_close_windows
to true.

Otherwise it will create over 100 windows if you run all the tests.
"
Class {
	#name : #PjBridgeTestCase,
	#superclass : #PjAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#instVars : [
		'classFactory',
		'authorInitialName'
	],
	#pools : [
		'PjDomGlobals',
		'PjUniversalGlobals'
	],
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #'suite parameters' }
PjBridgeTestCase class >> appClass [

	^ PjMinimalWebApplication
]

{ #category : #'test support' }
PjBridgeTestCase >> addToDOM: html [

	self bridge evalBlock: [ 
		| div |
		div := document createElement: 'div'.
		div innerHTML: html.
		document body appendChild: div ]
]

{ #category : #'test support' }
PjBridgeTestCase >> checkBasic: value [

	self
		assert:
			((PjMessageEvaluationResponse newWithContents: value asJSON) 
				 getValueWithBridge: self bridge)
		equals: value
]

{ #category : #'test support' }
PjBridgeTestCase >> checkProxy: value [

	self
		assert:
			((PjMessageEvaluationResponse newWithContents: (PjProxyInfo new
					   globalName: value asJSON;
					   yourself)) getValueWithBridge: self bridge)
		equals: value
]

{ #category : #running }
PjBridgeTestCase >> setUp [

	super setUp.
	authorInitialName := Author uniqueInstance fullNamePerSe.
	Author uniqueInstance fullName: 'PharoJS'.
	classFactory := ClassFactoryForTestCase new
]

{ #category : #running }
PjBridgeTestCase >> tearDown [

	super tearDown.
	classFactory ifNotNil: [ classFactory cleanUp ].
	Author uniqueInstance fullName: authorInitialName
]

{ #category : #'test support' }
PjBridgeTestCase >> transpileMethod: aMethod [

	^ self bridge transpiler transpileMethodToString: aMethod
]

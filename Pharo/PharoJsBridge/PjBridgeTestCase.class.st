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
	#superclass : #TestCase,
	#instVars : [
		'bridge',
		'debugging',
		'classFactory'
	],
	#pools : [
		'PjDomGlobals',
		'PjUniversalGlobals'
	],
	#category : #'PharoJsBridge-Tests'
}

{ #category : #testing }
PjBridgeTestCase >> addToDOM: html [
	bridge evalBlock: [| div |
		div := document createElement: 'div'.
		div innerHTML: html.
		document body appendChild: div]
]

{ #category : #testing }
PjBridgeTestCase >> assert: aBlock evaluatesTo: expectedResult [
	| actualResult |
	actualResult := bridge evalBlock: aBlock.
	self assert: actualResult equals: expectedResult.
]

{ #category : #testing }
PjBridgeTestCase >> assert: aBlock evaluatesToRaw: expectedJsonString [
	| actualResult |
	actualResult := bridge evalBlock: aBlock.
	self assert: actualResult asRawJSONString equals: expectedJsonString
]

{ #category : #testing }
PjBridgeTestCase >> assertBlock: aBlock [ 
	self assert: aBlock evaluatesTo: true
]

{ #category : #testing }
PjBridgeTestCase >> assertEquivalent: aBlock [
	self assert: aBlock evaluatesTo: aBlock value
]

{ #category : #testing }
PjBridgeTestCase >> assertJavascript: expressionString evaluatesTo: expectedResultString [ 
	self assert: (bridge evalJavascript: expressionString) equals: expectedResultString.
]

{ #category : #testing }
PjBridgeTestCase >> checkBasic: value [
	self assert: (bridge evalResult: value asJSON) equals: value
]

{ #category : #testing }
PjBridgeTestCase >> checkProxy: value [
	self assert: (bridge evalResult: '{"proxy":"',value asJSON,'"}') equals: value
]

{ #category : #testing }
PjBridgeTestCase >> debug [
	[ self copy setToDebug runCase ]
		ensure: [ self classForTestResource resetResources: self resources ]
]

{ #category : #testing }
PjBridgeTestCase >> initialize [
	super initialize.
	debugging := false
]

{ #category : #testing }
PjBridgeTestCase >> newBridgeForDebug [
	| newBridge |
	newBridge := self newBridgeForRun.
	newBridge client codeGenerator: PjLoggingClientCodeGenerator new.
	^newBridge
]

{ #category : #testing }
PjBridgeTestCase >> newBridgeForRun [
	^PjBridge new
]

{ #category : #testing }
PjBridgeTestCase >> setToDebug [
	debugging := true
]

{ #category : #testing }
PjBridgeTestCase >> setUp [
	super setUp.
	debugging ifNil: [ debugging := false ].
	bridge := PjBridge new.
	debugging
		ifTrue: [ bridge withClientLogging ]
		ifFalse: [ bridge client openBrowserInBackground: true.
			self inform: 'Web browser should open in background'.
			World doOneCycle;doOneCycle].
	bridge appClass: PjBrowserBridgeDefaultAppForTest.
	bridge openOn: 63425 test: self.
	bridge start.
	PjBridge bridge: bridge.
	classFactory := ClassFactoryForTestCase new. 

]

{ #category : #testing }
PjBridgeTestCase >> tearDown [
	super tearDown.
	bridge stop.
	classFactory ifNotNil: [ classFactory cleanUp ].
]

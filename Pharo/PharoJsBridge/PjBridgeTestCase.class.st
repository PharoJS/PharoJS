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

{ #category : #'test support' }
PjBridgeTestCase >> addToDOM: html [
	bridge evalBlock: [| div |
		div := document createElement: 'div'.
		div innerHTML: html.
		document body appendChild: div]
]

{ #category : #asserting }
PjBridgeTestCase >> assert: aBlock evaluatesTo: expectedResult [
	| actualResult |
	actualResult := bridge evalBlock: aBlock.
	expectedResult isNumber ifTrue: [expectedResult isNaN ifTrue: [ ^ self assert: actualResult isNaN ]].
	self assert: actualResult equals: expectedResult.
]

{ #category : #asserting }
PjBridgeTestCase >> assert: aBlock evaluatesToRaw: expectedJsonString [
	| actualResult |
	actualResult := bridge evalBlock: aBlock.
	self assert: actualResult asRawJSONString equals: expectedJsonString
]

{ #category : #asserting }
PjBridgeTestCase >> assertBlock: aBlock [ 
	self assert: aBlock evaluatesTo: true
]

{ #category : #asserting }
PjBridgeTestCase >> assertEquivalent: aBlock [
	self assert: aBlock evaluatesTo: aBlock value
]

{ #category : #asserting }
PjBridgeTestCase >> assertJavascript: expressionString evaluatesTo: expectedResultString [ 
	self assert: (bridge evalJavascript: expressionString) equals: expectedResultString.
]

{ #category : #'test support' }
PjBridgeTestCase >> checkBasic: value [
	self assert: (bridge evalResult: value asJSON) equals: value
]

{ #category : #'test support' }
PjBridgeTestCase >> checkProxy: value [
	self assert: (bridge evalResult: '{"proxy":"',value asJSON,'"}') equals: value
]

{ #category : #'test support' }
PjBridgeTestCase >> debug [
	[ self copy setToDebug runCase ]
		ensure: [ self classForTestResource resetResources: self resources ]
]

{ #category : #'test support' }
PjBridgeTestCase >> evalBlock: aBlock [
	^bridge evalBlock: aBlock
]

{ #category : #initialization }
PjBridgeTestCase >> initialize [
	super initialize.
	debugging := false
]

{ #category : #'test support' }
PjBridgeTestCase >> newBridgeForDebug [
	| newBridge |
	newBridge := self newBridgeForRun.
	newBridge client codeGenerator: PjLoggingClientCodeGenerator new.
	^newBridge
]

{ #category : #'test support' }
PjBridgeTestCase >> newBridgeForRun [
	^PjBridge new
]

{ #category : #running }
PjBridgeTestCase >> setToDebug [
	debugging := true
]

{ #category : #running }
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

{ #category : #running }
PjBridgeTestCase >> tearDown [
	super tearDown.
	bridge stop.
	classFactory ifNotNil: [ classFactory cleanUp ].
]

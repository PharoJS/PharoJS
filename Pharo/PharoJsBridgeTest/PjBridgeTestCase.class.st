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
	#category : #'PharoJsBridgeTest-Tests'
}

{ #category : #'suite parameters' }
PjBridgeTestCase class >> appClass [
	^PjMinimalApp
]

{ #category : #'test support' }
PjBridgeTestCase >> addToDOM: html [
	self bridge
		evalBlock: [ | div |
			div := document createElement: 'div'.
			div innerHTML: html.
			document body appendChild: div ]
]

{ #category : #asserting }
PjBridgeTestCase >> assert: aBlock evaluatesTo: expectedResult [
	| actualResult |
	actualResult := self bridge evalBlock: aBlock.
	expectedResult isCollection ifTrue: [
		expectedResult withIndexDo: [: each : index | | v |
			v := actualResult at: index.
			self assert: each = v
				description: [ (self comparingStringBetween: v and: each), ' at index ',index asString ] 
		].
		^ self
	].
	expectedResult isNumber
		ifTrue: [ expectedResult isNaN
				ifTrue: [ ^ self assert: actualResult isNaN ] ].
	self assert: actualResult equals: expectedResult
]

{ #category : #asserting }
PjBridgeTestCase >> assert: aBlock evaluatesToRaw: expectedJsonString [
	| actualResult |
	actualResult := self bridge evalBlock: aBlock.
	self assert: actualResult asRawJSONString equals: expectedJsonString
]

{ #category : #asserting }
PjBridgeTestCase >> assertBlock: aBlock [ 
	self assert: aBlock evaluatesTo: true
]

{ #category : #asserting }
PjBridgeTestCase >> assertBlock: block1 equalsBlock: block2 [
	| result1 result2 |
	result1 := self evalBlock: block1.
	result2 := self evalBlock: block2.
	self assert: result1 = result2
]

{ #category : #asserting }
PjBridgeTestCase >> assertEquivalent: aBlock [
	self assert: aBlock evaluatesTo: aBlock value
]

{ #category : #asserting }
PjBridgeTestCase >> assertJavascript: expressionString evaluatesTo: expectedResultString [
	self
		assert: (self bridge evalJavascript: expressionString)
		equals: expectedResultString
]

{ #category : #'test support' }
PjBridgeTestCase >> checkBasic: value [
	self assert: (self bridge evalResult: value asJSON) equals: value
]

{ #category : #'test support' }
PjBridgeTestCase >> checkProxy: value [
	self
		assert: (self bridge evalResult: '{"proxy":"' , value asJSON , '"}')
		equals: value
]

{ #category : #asserting }
PjBridgeTestCase >> denyBlock: block1 equalsBlock: block2 [
	| result1 result2 |
	result1 := self evalBlock: block1.
	result2 := self evalBlock: block2.
	self deny: result1 = result2
]

{ #category : #'test support' }
PjBridgeTestCase >> evalBlock: aBlock [
	^ self bridge evalBlock: aBlock
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
	Author uniqueInstance fullName: authorInitialName.

]

{ #category : #'test support' }
PjBridgeTestCase >> transpileMethod: aMethod [
	^ self bridge transpiler transpileMethodToString: aMethod
]

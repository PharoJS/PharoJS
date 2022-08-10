Class {
	#name : #PjAppTestCase,
	#superclass : #ParametrizedTestCase,
	#traits : 'PjTWaitUntilReady + PjTAppRunsInPharo',
	#classTraits : 'PjTWaitUntilReady classTrait + PjTAppRunsInPharo classTrait',
	#instVars : [
		'app',
		'bridgeResourceClass'
	],
	#pools : [
		'PjUniversalGlobals'
	],
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #'suite parameters' }
PjAppTestCase class >> appClass [
	^self subclassResponsibility
]

{ #category : #testing }
PjAppTestCase class >> isAbstract [
	^self == PjAppTestCase or: [
		#(currentApp appClassToExport) anySatisfy: [: selector |
			(self canUnderstand: selector) not] ].
]

{ #category : #accessing }
PjAppTestCase >> appClass [
	^self class appClass
]

{ #category : #testing }
PjAppTestCase >> assert: aBlock evaluatesTo: expectedResult [
	| actualResult |
	actualResult := self evalBlock: aBlock.
	self assert: actualResult equals: expectedResult.
]

{ #category : #testing }
PjAppTestCase >> assertBlock: aBlock [ 
	self assert: aBlock evaluatesTo: true
]

{ #category : #testing }
PjAppTestCase >> assertSmalltalk: smalltalkExpressionString resultsInto: expected [
	| actual | 
	actual := self eval: smalltalkExpressionString.
	self assert: actual equals: expected.
]

{ #category : #accessing }
PjAppTestCase >> bridge [
	^self bridgeResource bridge
]

{ #category : #accessing }
PjAppTestCase >> bridgeResource [
	^ self bridgeResourceClass current
]

{ #category : #accessing }
PjAppTestCase >> bridgeResourceClass [
	^bridgeResourceClass ifNil: [ self defaultBridgeResourceClass ]
]

{ #category : #private }
PjAppTestCase >> cleanUpInstanceVariables [
	| ivsToReset |
	ivsToReset := self class allInstVarNames copyWithoutAll: #(testSelector bridgeResourceClass).
	ivsToReset do: [ :name |
		self instVarNamed: name put: nil ]
]

{ #category : #running }
PjAppTestCase >> debug [
	bridgeResourceClass := self debugBridgeResourceClass.
	^super debug
]

{ #category : #running }
PjAppTestCase >> debugBridgeResourceClass [
	^PjDebugBridgeTestResource
]

{ #category : #accessing }
PjAppTestCase >> defaultBridgeResourceClass [
	^PjBridgeTestResource
]

{ #category : #testing }
PjAppTestCase >> evalBlock: aBlock [
	^self bridge evalBlock: aBlock
]

{ #category : #testing }
PjAppTestCase >> resetApp [
	self bridge resetClient.
	self resetInstanceVariables
]

{ #category : #testing }
PjAppTestCase >> resetInstanceVariables [
	app := self currentApp.
]

{ #category : #accessing }
PjAppTestCase >> resources [
	^super resources, {self bridgeResourceClass}
]

{ #category : #running }
PjAppTestCase >> runCaseAsFailure: aSemaphore [
	"Used for debug purpose. See TestCase>>#debugAsFailure"
	bridgeResourceClass := self debugBridgeResourceClass.
	super runCaseAsFailure: aSemaphore
]

{ #category : #running }
PjAppTestCase >> setUp [

	super setUp.
	self waitWhile: [ self currentApp isNil ] timeOut: self timeOutForAppStartUp.
	self resetInstanceVariables.

]

{ #category : #running }
PjAppTestCase >> tearDown [
	super tearDown.
	self appClass resetCurrentInstance.
	self bridge resetProxiesImmediately.
	"bridgeResourceClass := nil"
]

{ #category : #testing }
PjAppTestCase >> timeOutForAppStartUp [
	^3 seconds
]

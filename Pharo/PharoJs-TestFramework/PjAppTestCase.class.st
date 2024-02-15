Class {
	#name : #PjAppTestCase,
	#superclass : #ParametrizedTestCase,
	#traits : 'PjTWaitUntilReady + PjTAppRunsInPharo',
	#classTraits : 'PjTWaitUntilReady classTrait @ {#defaultWaitTimeoutDuration->#waitTimeoutDuration. #defaultWaitStepDuration->#waitStepDuration} + PjTAppRunsInPharo classTrait',
	#instVars : [
		'app',
		'bridgeResourceClass'
	],
	#classVars : [
		'WaitStepDuration',
		'WaitTimeOutDuration'
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

{ #category : #waiting }
PjAppTestCase class >> waitStepDuration [

	^ WaitStepDuration ifNil: [ WaitStepDuration := self defaultWaitStepDuration ]
]

{ #category : #waiting }
PjAppTestCase class >> waitStepDuration: aDuration [

	WaitStepDuration := aDuration
]

{ #category : #waiting }
PjAppTestCase class >> waitTimeoutDuration [

	^ WaitTimeOutDuration ifNil: [
		  WaitTimeOutDuration := self defaultWaitTimeoutDuration ]
]

{ #category : #waiting }
PjAppTestCase class >> waitTimeoutDuration: aDuration [

		  WaitTimeOutDuration := aDuration 
]

{ #category : #accessing }
PjAppTestCase >> app [
	^app
]

{ #category : #accessing }
PjAppTestCase >> appClass [
	^self class appClass
]

{ #category : #asserting }
PjAppTestCase >> assert: aBlock evaluatesTo: expectedResult [

	| actualResult |
	actualResult := (self bridge evalBlock: aBlock) asLocalObject.
	expectedResult isNumber ifTrue: [ 
		expectedResult isNaN ifTrue: [ ^ self assert: actualResult isNaN ] ].
	self assert: actualResult equals: expectedResult
]

{ #category : #asserting }
PjAppTestCase >> assert: aBlock evaluatesToRaw: expectedJsonString [

	| actualResult |
	actualResult := self bridge evalBlock: aBlock.
	self assert: actualResult asRawJSONString equals: expectedJsonString
]

{ #category : #testing }
PjAppTestCase >> assertBlock: aBlock [ 
	self assert: aBlock evaluatesTo: true
]

{ #category : #asserting }
PjAppTestCase >> assertBlock: block1 equalsBlock: block2 [

	| result1 result2 |
	result1 := self evalBlock: block1.
	result2 := self evalBlock: block2.
	self assert: result1 = result2
]

{ #category : #asserting }
PjAppTestCase >> assertEquivalent: aBlock [

	self assert: aBlock evaluatesTo: aBlock value
]

{ #category : #asserting }
PjAppTestCase >> assertJavascript: expressionString evaluatesTo: expectedResultString [

	self
		assert: (self bridge evalJavascript: expressionString)
		equals: expectedResultString
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

	^ bridgeResourceClass ifNil: [bridgeResourceClass := self defaultBridgeResourceClass ]
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
PjAppTestCase >> denyBlock: aBlock [ 
	self assert: aBlock evaluatesTo: false
]

{ #category : #asserting }
PjAppTestCase >> denyBlock: block1 equalsBlock: block2 [

	| result1 result2 |
	result1 := self evalBlock: block1.
	result2 := self evalBlock: block2.
	self deny: result1 equals: result2
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
	^ 20 seconds
]

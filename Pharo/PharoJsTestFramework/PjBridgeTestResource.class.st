Class {
	#name : #PjBridgeTestResource,
	#superclass : #TestResource,
	#traits : 'PjTWaitUntilReady',
	#classTraits : 'PjTWaitUntilReady classTrait',
	#instVars : [
		'bridge'
	],
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #running }
PjBridgeTestResource >> appClass [
	^PjBrowserApplication 
]

{ #category : #accessing }
PjBridgeTestResource >> bridge [
	^ bridge
]

{ #category : #accessing }
PjBridgeTestResource >> bridge: aBridge [
	bridge := aBridge.

]

{ #category : #running }
PjBridgeTestResource >> bridgePort [
	^2222
]

{ #category : #testing }
PjBridgeTestResource >> defaultTimeOutActionBlock [
	^[ self fail ]
]

{ #category : #testing }
PjBridgeTestResource >> defaultWaitTimeOutDuration [ 
	^2 seconds
]

{ #category : #'initialize-release' }
PjBridgeTestResource >> initialize [
	super initialize.
	self description: 'PharoJS Bridge for Test'.
	self name: 'PharoJS Bridge TestResource'.
]

{ #category : #testing }
PjBridgeTestResource >> isAvailable [
	^self bridge server isListening.
]

{ #category : #running }
PjBridgeTestResource >> maxWaitDuration [
	^2 seconds
]

{ #category : #running }
PjBridgeTestResource >> setUp [
	super setUp.
	self setUpBridge.
	self startBridge.
	self waitUntilBridgeReady.

]

{ #category : #running }
PjBridgeTestResource >> setUpBridge [
	self bridge: self appClass bridge. 

]

{ #category : #running }
PjBridgeTestResource >> startBridge [
	self bridge	startOn: self bridgePort title: nil.
]

{ #category : #testing }
PjBridgeTestResource >> stepDuration [
	^50 milliSeconds
]

{ #category : #running }
PjBridgeTestResource >> tearDown [
	super tearDown.
	self bridge stop
]

{ #category : #running }
PjBridgeTestResource >> waitUntilBridgeReady [
	self waitWhile: [bridge isListening not]

]

{ #category : #testing }
PjBridgeTestResource >> waitWhile: conditionBlock [
	self waitWhile: conditionBlock timeOut: self defaultWaitTimeOutDuration 
]

{ #category : #testing }
PjBridgeTestResource >> waitWhile: conditionBlock timeOut: maxToWait [ 
	self
		waitWhile: conditionBlock 
		timeOut: maxToWait 
		ifTimeOutDo: self defaultTimeOutActionBlock
]

{ #category : #testing }
PjBridgeTestResource >> waitWhile: conditionBlock timeOut: maxToWait ifTimeOutDo: timeOutBlock [
	| totalWaited |
	totalWaited := 0 second.
	[totalWaited < maxToWait and: conditionBlock] whileTrue: [
		self stepDuration wait.
		totalWaited := totalWaited + self stepDuration].
	totalWaited >= maxToWait ifTrue: timeOutBlock
]

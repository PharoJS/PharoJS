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
PjBridgeTestResource >> maxWaitClientReadyDuration [
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
	self bridge	startWithoutWaitingForClient
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

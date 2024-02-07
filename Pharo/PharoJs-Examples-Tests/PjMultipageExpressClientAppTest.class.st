Class {
	#name : #PjMultipageExpressClientAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#instVars : [
		'bridgePage1',
		'bridgePage2',
		'bridgePage3',
		'bridge'
	],
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #accessing }
PjMultipageExpressClientAppTest >> allPageBridges [
	self subclassResponsibility 
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> appClass [ 
	self bridge ifNil: [ ^super appClass  ].
	^self bridge appClass
]

{ #category : #running }
PjMultipageExpressClientAppTest >> assertConnected: aBridge [

	| otherBridges |
	self waitUntil: [ aBridge isConnected ].
	self bridge: aBridge.
	self resetInstanceVariables.
	self assert: app identicalTo: aBridge app.
	otherBridges := self allPageBridges copyWithout: aBridge.
	otherBridges do: [ :each | self deny: each isConnected ]
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> bridge [
	^bridge ifNil: [ super bridge ]
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> bridge: aBridge [

	bridge := aBridge.
	PjBridge soleBridge: bridge
]

{ #category : #running }
PjMultipageExpressClientAppTest >> initBridges [

	self subclassResponsibility
]

{ #category : #running }
PjMultipageExpressClientAppTest >> setUp [

	super setUp.
	self initBridges.
	self setUpOtherBridges
]

{ #category : #running }
PjMultipageExpressClientAppTest >> setUpOtherBridges [
	| serverBridge otherBridges |
	serverBridge := self bridge client serverBridge.
	otherBridges := self allPageBridges copyWithout: self bridge.
	otherBridges do: [ :eachBridge |
			eachBridge client serverBridge: serverBridge.
			eachBridge shouldStartJsInterpreter: false.
			eachBridge startWithoutWaitingForClient ]
]

{ #category : #running }
PjMultipageExpressClientAppTest >> stopBridge: aBridge [

	aBridge ifNil: [ ^ self ].
	aBridge client serverBridge: nil.
	aBridge stop.
	self waitUntil: [ aBridge isServerStopped ]
]

{ #category : #running }
PjMultipageExpressClientAppTest >> tearDown [

	self tearDownPageBridges.
	super tearDown
]

{ #category : #running }
PjMultipageExpressClientAppTest >> tearDownPageBridges [
	"Ensure client won't stop the bridge to the expressJs server that is managed by the resource and thus reused accross multiple tests cases."

	| otherBridges |
	otherBridges := self allPageBridges copyWithout:
		                self bridgeResource bridge.
	otherBridges do: [ :each | self stopBridge: each ]
]

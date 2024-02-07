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

{ #category : #'suite parameters' }
PjMultipageExpressClientAppTest class >> appClass [

	^PjPage1InMultipageExpressApp
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> allBridges [
	^{bridgePage1 . bridgePage2 . bridgePage3}
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
	otherBridges := self allBridges copyWithout: aBridge.
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
PjMultipageExpressClientAppTest >> click: buttonID [

	| button |
	button := document getElementById: buttonID.
	self deny: button isNil.
	button click
]

{ #category : #running }
PjMultipageExpressClientAppTest >> setUp [

	| serverBridge |
	super setUp.
	bridgePage1 := self bridge.
	bridgePage2 := PjPage2InMultipageExpressApp bridge.
	bridgePage3 := PjPage3InMultipageExpressApp bridge.
	serverBridge := bridgePage1 client serverBridge.
	{
		bridgePage2.
		bridgePage3 } do: [ :otherBridge |
			otherBridge client serverBridge: serverBridge.
			otherBridge shouldStartJsInterpreter: false.
			otherBridge startWithoutWaitingForClient ]
]

{ #category : #running }
PjMultipageExpressClientAppTest >> stopBridge: aBridge [

	aBridge ifNil: [ ^ self ].
	aBridge == self bridgeResource bridge ifTrue: [ ^ self ].
	"Ensure client won't stop the the bridge to the expressJs server that is managed by the resource and thus reused accross multiple tests cases. BTW, this is dirty the expressJs server should be restarted upon running each test case!"
	aBridge client serverBridge: nil.
	aBridge stop.
	self waitUntil: [ aBridge isServerStopped ]
]

{ #category : #running }
PjMultipageExpressClientAppTest >> tearDown [

	self allBridges do: [ :each | self stopBridge: each ].
	super tearDown
]

{ #category : #running }
PjMultipageExpressClientAppTest >> testNavigateBackUsingHistory [
	self fail: #todo
]

{ #category : #running }
PjMultipageExpressClientAppTest >> testNavigateFromPage1ToPage2AndToPage3 [

	self assertConnected: bridgePage1.
	self click: #goToPage2Button.
	self assertConnected: bridgePage2.
	self click: #goToPage3Button.
	self assertConnected: bridgePage3.
	self click: #goToPage1Button.
	self assertConnected: bridgePage1
]
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
PjMultipageExpressClientAppTest >> assertConnected: aBridge [

	| otherBridges |
	self waitUntil: [ aBridge isConnected ].
	self bridge: aBridge.
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

	bridge := aBridge
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> click: buttonID [
	| button |
	button := document getElementByID: buttonID.
	self deny: button isNil.
	button click.
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> setUp [

	| serverBridge |
	super setUp.
	bridgePage1 := self bridge.
	bridgePage2 := PjPage2InMultipageExpressApp bridge.
	bridgePage3 := PjPage3InMultipageExpressApp bridge.
	serverBridge := bridgePage1 client serverBridge.
	{ bridgePage2 . bridgePage3  } do: [ : otherBridge | 
		otherBridge client serverBridge: serverBridge.
		otherBridge shouldStartJsInterpreter: false.
		otherBridge startWithoutWaitingForClient.
	]
		
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> stopBridge: aBridge [
	aBridge ifNil: [ ^self ].
	aBridge stop
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> tearDown [
	self allBridges do: [ :each | self stopBridge: each ].
	super tearDown
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> testNavigateBackUsingHistory [
	self fail: #todo
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> testNavigateFromPage1ToPage2AndToPage3 [

	self assertConnected: bridgePage1.
	self click: #goToPage2Button.
	self assertConnected: bridgePage2.
	self click: #goToPage3Button.
	self assertConnected: bridgePage3.
	self click: #goToPage1Button.
	self assertConnected: bridgePage1
]

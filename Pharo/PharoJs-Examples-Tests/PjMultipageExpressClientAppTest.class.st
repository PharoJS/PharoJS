Class {
	#name : #PjMultipageExpressClientAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#instVars : [
		'bridgePage1',
		'bridgePage2',
		'bridgePage3',
		'activeBridge',
		'pageViewer'
	],
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #'suite parameters' }
PjMultipageExpressClientAppTest class >> appClass [

	^ PjPageViewerApp 
]

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
	^activeBridge ifNil: [ super bridge ]
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> bridge: aBridge [

	activeBridge := aBridge.
	PjBridge soleBridge: activeBridge
]

{ #category : #running }
PjMultipageExpressClientAppTest >> createPageBridges [

	self subclassResponsibility
]

{ #category : #running }
PjMultipageExpressClientAppTest >> openPageOfBridge: aBridge [

	
	pageViewer open: aBridge client urlString.
	self assertConnected:aBridge
]

{ #category : #running }
PjMultipageExpressClientAppTest >> setUp [

	super setUp.
	pageViewer := app.
	self createPageBridges.
	self setUpPageBridges
]

{ #category : #running }
PjMultipageExpressClientAppTest >> setUpPageBridges [

	| serverBridge serverManagerBridge otherPageBridges |
	serverManagerBridge := self allPageBridges anyOne.
	serverManagerBridge
		shouldStartJsInterpreter: false;
		startWithoutWaitingForClient.
	serverBridge := serverManagerBridge client serverBridge.
	otherPageBridges := self allPageBridges copyWithout: serverManagerBridge.
	otherPageBridges do: [ :eachBridge |
		eachBridge client serverBridge: serverBridge.
		eachBridge shouldStartJsInterpreter: false.
		eachBridge startWithoutWaitingForClient ]
]

{ #category : #running }
PjMultipageExpressClientAppTest >> tearDown [

	self tearDownPageBridges.
	super tearDown
]

{ #category : #running }
PjMultipageExpressClientAppTest >> tearDownPageBridges [

	self allPageBridges do: [ :each |
		each stop. ]
]

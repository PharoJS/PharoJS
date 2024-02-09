Class {
	#name : #PjMultipageExpressClientAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#instVars : [
		'activeBridge',
		'pageViewer',
		'serverManagerBridge',
		'pageBridgesDict'
	],
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #'suite parameters' }
PjMultipageExpressClientAppTest class >> appClass [

	^ PjPageViewerApp 
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> appClass [ 
	self bridge ifNil: [ ^super appClass  ].
	^self bridge appClass
]

{ #category : #running }
PjMultipageExpressClientAppTest >> assertShowingPage: anAppClass [

	| otherBridges pageBridge |
	pageBridge := pageBridgesDict
		              at: anAppClass.
	self waitUntil: [ pageBridge isConnected ].
	self bridge: pageBridge.
	self resetInstanceVariables.
	self assert: app identicalTo: pageBridge app.
	otherBridges := self pageBridges copyWithout: pageBridge.
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

	pageBridgesDict := IdentityDictionary new.
	self pageAppClasses do: [ : class | 
		pageBridgesDict at: class put: class bridge
		]
]

{ #category : #running }
PjMultipageExpressClientAppTest >> openPage: anAppClass [

	| pageBridge |
	pageBridge := pageBridgesDict at: anAppClass.
	pageViewer open: pageBridge client urlString.
	self assertShowingPage: anAppClass
]

{ #category : #running }
PjMultipageExpressClientAppTest >> pageAppClasses [
	self subclassResponsibility 
]

{ #category : #accessing }
PjMultipageExpressClientAppTest >> pageBridges [

	^pageBridgesDict values
]

{ #category : #running }
PjMultipageExpressClientAppTest >> setUp [

	super setUp.
	pageViewer := app.
	self setUpPageBridges
]

{ #category : #running }
PjMultipageExpressClientAppTest >> setUpOtherPageBridges [

	| otherPageBridges serverBridge |
	serverBridge := serverManagerBridge client serverBridge.
	otherPageBridges := self pageBridges copyWithout:
		                    serverManagerBridge.
	otherPageBridges do: [ :eachBridge |
		eachBridge client serverBridge: serverBridge.
		eachBridge shouldStartJsInterpreter: false.
		eachBridge startWithoutWaitingForClient ]
]

{ #category : #running }
PjMultipageExpressClientAppTest >> setUpPageBridges [

	self createPageBridges.
	self setUpServerManagerBridge.
	self setUpOtherPageBridges
]

{ #category : #running }
PjMultipageExpressClientAppTest >> setUpServerManagerBridge [

	serverManagerBridge := self pageBridges anyOne.
	serverManagerBridge
		shouldStartJsInterpreter: false;
		startWithoutWaitingForClient
]

{ #category : #running }
PjMultipageExpressClientAppTest >> tearDown [

	self tearDownPageBridges.
	super tearDown
]

{ #category : #running }
PjMultipageExpressClientAppTest >> tearDownPageBridges [

	self pageBridges do: [ :each |
		each stop. ]
]

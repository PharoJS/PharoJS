"
Root class for testing express JS clients with multiple pages. 
Each page is controlled via an app instance of a subclass of PjWebApplication.

- Subclasses should define pageAppClasses that answers the list of app classes for all pages to be tested.
- A test can directly open a given page using method #openPage: which argument is the app class of the page to open.
- A test can assert that a page is displayed using method #assertShowingPage:  which argument is the app class of the expected page

Implementation
Relies on PjPageViewerApp to open pages and eventually upon tearDown close them

"
Class {
	#name : #PjMultipageExpressClientTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#instVars : [
		'activeBridge',
		'pageViewer',
		'serverManagerBridge',
		'pageBridgesDict'
	],
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #'suite parameters' }
PjMultipageExpressClientTest class >> appClass [

	^ PjPageViewerApp 
]

{ #category : #testing }
PjMultipageExpressClientTest class >> isAbstract [ 
	^self == PjMultipageExpressClientTest 
]

{ #category : #accessing }
PjMultipageExpressClientTest >> appClass [ 
	self bridge ifNil: [ ^super appClass  ].
	^self bridge appClass
]

{ #category : #running }
PjMultipageExpressClientTest >> assertShowingPage: anAppClass [

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
PjMultipageExpressClientTest >> bridge [
	^activeBridge ifNil: [ super bridge ]
]

{ #category : #accessing }
PjMultipageExpressClientTest >> bridge: aBridge [

	activeBridge := aBridge.
	PjBridge soleBridge: activeBridge
]

{ #category : #running }
PjMultipageExpressClientTest >> createPageBridges [

	pageBridgesDict := IdentityDictionary new.
	self pageAppClasses do: [ : class | 
		pageBridgesDict at: class put: class bridge
		]
]

{ #category : #running }
PjMultipageExpressClientTest >> openPage: anAppClass [

	| pageBridge |
	pageBridge := pageBridgesDict at: anAppClass.
	pageViewer open: pageBridge client urlString.
	self assertShowingPage: anAppClass
]

{ #category : #running }
PjMultipageExpressClientTest >> pageAppClasses [
	self subclassResponsibility 
]

{ #category : #accessing }
PjMultipageExpressClientTest >> pageBridges [

	^pageBridgesDict values
]

{ #category : #running }
PjMultipageExpressClientTest >> setUp [

	super setUp.
	pageViewer := app.
	self setUpPageBridges
]

{ #category : #running }
PjMultipageExpressClientTest >> setUpOtherPageBridges [

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
PjMultipageExpressClientTest >> setUpPageBridges [

	self createPageBridges.
	self setUpServerManagerBridge.
	self setUpOtherPageBridges
]

{ #category : #running }
PjMultipageExpressClientTest >> setUpServerManagerBridge [

	serverManagerBridge := self pageBridges anyOne.
	serverManagerBridge
		shouldStartJsInterpreter: false;
		startWithoutWaitingForClient
]

{ #category : #running }
PjMultipageExpressClientTest >> tearDown [

	self tearDownPageBridges.
	super tearDown
]

{ #category : #running }
PjMultipageExpressClientTest >> tearDownPageBridges [

	self pageBridges do: [ :each |
		each stop. ]
]

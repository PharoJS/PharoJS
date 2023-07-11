Class {
	#name : #PjWebClientAppBridgeTestResource,
	#superclass : #PjBridgeTestResource,
	#instVars : [
		'serverBridge',
		'serverClassName',
		'urlPathString'
	],
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #accessing }
PjWebClientAppBridgeTestResource >> bridgeForAppClass [
	| bridgeClient |
	bridgeClient := PjWebServedBridgeClient 
		                      newWithAppClass: self appClass.
	^PjBridge
		                bridgeForAppClass: self appClass
		                client: bridgeClient.
	
]

{ #category : #initialization }
PjWebClientAppBridgeTestResource >> initBridgeClientUrl [

	| serverApp serverPort |
	serverApp := serverBridge
		             evalSelector: #currentInstance
		             sentTo: serverClassName.
	serverPort := serverApp port.
	self bridge client urlString:
		'http://localhost:' , serverPort asString , urlPathString
]

{ #category : #initialization }
PjWebClientAppBridgeTestResource >> initFrom: aTestAsserter [

	serverBridge := aTestAsserter serverAppClass bridge.
	serverClassName := aTestAsserter serverAppClass name.
	urlPathString := aTestAsserter urlPathString.
	serverBridge shouldStartJsInterpreter: false.
	self startBridge: serverBridge.
	super initFrom: aTestAsserter
]

{ #category : #running }
PjWebClientAppBridgeTestResource >> resetClient [

	super resetClient.
	serverBridge resetClient.

]

{ #category : #running }
PjWebClientAppBridgeTestResource >> startJsInterpreter [

	serverBridge startJsInterpreter.
	self initBridgeClientUrl.
	super startJsInterpreter
]

{ #category : #running }
PjWebClientAppBridgeTestResource >> tearDown [
	serverBridge stop.
	super tearDown.
	
]

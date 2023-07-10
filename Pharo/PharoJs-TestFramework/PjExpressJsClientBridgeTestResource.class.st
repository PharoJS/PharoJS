Class {
	#name : #PjExpressJsClientBridgeTestResource,
	#superclass : #PjBridgeTestResource,
	#instVars : [
		'serverBridge',
		'serverClassName',
		'urlPath'
	],
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #accessing }
PjExpressJsClientBridgeTestResource >> bridgeForAppClass [
	| bridgeClient |
	bridgeClient := PjWebServedBridgeClient 
		                      newWithAppClass: self appClass.
	^PjBridge
		                bridgeForAppClass: self appClass
		                client: bridgeClient.
	
]

{ #category : #initialization }
PjExpressJsClientBridgeTestResource >> initBridgeClientUrl [

	| serverApp serverPort |
	serverApp := serverBridge
		             evalSelector: #currentInstance
		             sentTo: serverClassName.
	serverPort := serverApp port.
	self bridge client urlString:
		'http://localhost:' , serverPort asString , urlPath
]

{ #category : #initialization }
PjExpressJsClientBridgeTestResource >> initFrom: aTestAsserter [

	serverBridge := aTestAsserter serverClass bridge.
	serverClassName := aTestAsserter serverClass name.
	urlPath := aTestAsserter urlPath.
	serverBridge shouldStartJsInterpreter: false.
	self startBridge: serverBridge.
	super initFrom: aTestAsserter
]

{ #category : #running }
PjExpressJsClientBridgeTestResource >> resetClient [

	serverBridge resetClient.
	super resetClient
]

{ #category : #running }
PjExpressJsClientBridgeTestResource >> startJsInterpreter [

	serverBridge startJsInterpreter.
	self initBridgeClientUrl.
	super startJsInterpreter
]

{ #category : #running }
PjExpressJsClientBridgeTestResource >> tearDown [
	serverBridge stop.
	super tearDown.
	
]

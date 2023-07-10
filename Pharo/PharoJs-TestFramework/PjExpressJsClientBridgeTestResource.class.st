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
	bridgeClient := PjExpressJsClientAppBridgeClient 
		                      newWithAppClass: self appClass.
	^PjBridge
		                bridgeForAppClass: self appClass
		                client: bridgeClient.
	
]

{ #category : #running }
PjExpressJsClientBridgeTestResource >> tearDown [
	serverBridge stop.
	super tearDown.
	
]

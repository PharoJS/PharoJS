Class {
	#name : #PjExpressJsClientAppBridgeClient,
	#superclass : #PjFileBasedBridgeClient,
	#traits : 'PjTWebBridgeClient',
	#classTraits : 'PjTWebBridgeClient classTrait',
	#instVars : [
		'urlString'
	],
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #'accessing - defaults' }
PjExpressJsClientAppBridgeClient >> defaultAppClass [

	^ PjMinimalWebApplication
]

{ #category : #accessing }
PjExpressJsClientAppBridgeClient >> urlString [

	^ urlString
]

{ #category : #accessing }
PjExpressJsClientAppBridgeClient >> urlString: anObject [

	urlString := anObject
]

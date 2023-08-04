Class {
	#name : #PjLocalWebServedBridgeClient,
	#superclass : #PjWebServedBridgeClient,
	#instVars : [
		'serverBridge'
	],
	#category : #'PharoJs-Base-Bridge-Client-Kernel'
}

{ #category : #initialization }
PjLocalWebServedBridgeClient >> start [

	| serverClass serverApp serverPort |
	serverBridge
		ifNil: [
			serverClass := appClass serverAppClass.
			serverBridge := serverClass bridge ]
.
	serverBridge isServerStarted ifTrue: [
		^ self ].
	serverBridge start.
	serverApp := serverBridge
		             evalSelector: #currentInstance
		             sentTo: serverClass name.
	serverPort := serverApp port.
	self urlString: 'http://127.0.0.1:' , serverPort asString.
	super start
]

{ #category : #actions }
PjLocalWebServedBridgeClient >> stop [

	serverBridge ifNotNil: [
		serverBridge stop ].
	super stop
]

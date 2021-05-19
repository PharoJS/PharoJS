"
I represent a web bridge client i.e. an interactive interpreter is launched upon start
"
Class {
	#name : #PjBrowserBridgeClient,
	#superclass : #PjBridgeClient,
	#traits : 'PjTBrowserController',
	#classTraits : 'PjTBrowserController classTrait',
	#classInstVars : [
		'defaultWebBrowserName'
	],
	#category : #'PharoJsBridge-Client-Kernel'
}

{ #category : #accessing }
PjBrowserBridgeClient class >> defaultWebBrowserName [
	^defaultWebBrowserName ifNil: [ self safari ]
]

{ #category : #accessing }
PjBrowserBridgeClient class >> defaultWebBrowserName: aString [
	defaultWebBrowserName := aString
]

{ #category : #accessing }
PjBrowserBridgeClient class >> firefox [
	^#firefox
]

{ #category : #accessing }
PjBrowserBridgeClient class >> makeFirefoxDefaultWebBrowser [
	self defaultWebBrowserName: self firefox
]

{ #category : #accessing }
PjBrowserBridgeClient class >> makeSafariDefaultWebBrowser [
	self defaultWebBrowserName: self safari
]

{ #category : #accessing }
PjBrowserBridgeClient class >> safari [
	^#safari
]

{ #category : #'initialization-release' }
PjBrowserBridgeClient >> defaultAppClass [
	^PjWebApplication
]

{ #category : #accessing }
PjBrowserBridgeClient >> exporterClass [
	^ PjExporter
]

{ #category : #accessing }
PjBrowserBridgeClient >> initializeWithBridge: aBridge [
	super initializeWithBridge: aBridge.
	self codeGenerator resetHtmlGenerator.
	self server css: self codeGenerator css.
	self server favicon: self codeGenerator favicon.
	self server html: self codeGenerator html.

]

{ #category : #accessing }
PjBrowserBridgeClient >> serverUrlString [
	^self server urlString
]

{ #category : #activity }
PjBrowserBridgeClient >> start [
	self bridge server
		javascript:
			(String
				streamContents: [ :aStream | self exporter writeJsCodeOn: aStream ]).
	super start
]

{ #category : #accessing }
PjBrowserBridgeClient >> urlString [
	^self serverUrlString 
]

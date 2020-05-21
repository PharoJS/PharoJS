"
I represent a web bridge client i.e. an interactive interpreter is launched upon start
"
Class {
	#name : #PjBrowserBridgeClient,
	#superclass : #PjBridgeClient,
	#instVars : [
		'openBrowserInBackground'
	],
	#category : #'PharoJsBridge-Client-Kernel'
}

{ #category : #accessing }
PjBrowserBridgeClient >> bridge: aBridge [
	super bridge: aBridge.
	self codeGenerator resetHtmlGenerator.
	self server css: self codeGenerator css.
	self server favicon: self codeGenerator favicon.
	self server html: self codeGenerator html.

]

{ #category : #'initialization-release' }
PjBrowserBridgeClient >> defaultAppClass [
	^PjWebApplication
]

{ #category : #accessing }
PjBrowserBridgeClient >> exporterClass [
	^ PjExporter
]

{ #category : #'initialization-release' }
PjBrowserBridgeClient >> initialize [
	super initialize.
	openBrowserInBackground := false.
]

{ #category : #accessing }
PjBrowserBridgeClient >> openBrowserInBackground [
	^ openBrowserInBackground
]

{ #category : #accessing }
PjBrowserBridgeClient >> openBrowserInBackground: anObject [
	openBrowserInBackground := anObject
]

{ #category : #activity }
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

{ #category : #activity }
PjBrowserBridgeClient >> startJsInterpreter [

"
self bridge isServerStartedExtraCheck
self bridge isServerIndexHtmlAvailable
self bridge isServerIndexJsAvailable
self serverUrlString
self bridge server isWebSocketConnected
"
	WebBrowser
		openOn: self serverUrlString
		inBackground: self openBrowserInBackground
]

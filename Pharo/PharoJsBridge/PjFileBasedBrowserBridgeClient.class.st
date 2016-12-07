Class {
	#name : #PjFileBasedBrowserBridgeClient,
	#superclass : #PjFileBasedBridgeClient,
	#category : #'PharoJsBridge-Client-Kernel'
}

{ #category : #'initialization-release' }
PjFileBasedBrowserBridgeClient >> defaultAppClass [
	^PjFileBasedBrowserApp
]

{ #category : #activity }
PjFileBasedBrowserBridgeClient >> openWebBrowserOn: appHtmlFileUrlString [
	WebBrowser openOn: appHtmlFileUrlString
]

{ #category : #activity }
PjFileBasedBrowserBridgeClient >> start [
	super start.
	self openWebBrowserOn: self appClass appHtmlUrlString
]

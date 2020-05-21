"
I am for browsers that have more resources than the CSS and HTML files that need to be loaded.
"
Class {
	#name : #PjFileBasedBrowserBridgeClient,
	#superclass : #PjFileBasedBridgeClient,
	#category : #'PharoJsBridge-Client-Kernel'
}

{ #category : #'initialization-release' }
PjFileBasedBrowserBridgeClient >> defaultAppClass [
	^PjFileBasedWebApp
]

{ #category : #activity }
PjFileBasedBrowserBridgeClient >> openWebBrowserOn: appHtmlFileUrlString [
	WebBrowser openOn: appHtmlFileUrlString
]

{ #category : #activity }
PjFileBasedBrowserBridgeClient >> startJsInterpreter [
	self openWebBrowserOn: self appClass appHtmlUrlString
]

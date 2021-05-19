"
I am for browsers that have more resources than the CSS and HTML files that need to be loaded.
"
Class {
	#name : #PjFileBasedBrowserBridgeClient,
	#superclass : #PjFileBasedBridgeClient,
	#traits : 'PjTBrowserController',
	#classTraits : 'PjTBrowserController classTrait',
	#category : #'PharoJsBridge-Client-Kernel'
}

{ #category : #'initialization-release' }
PjFileBasedBrowserBridgeClient >> defaultAppClass [
	^PjFileBasedWebApp
]

{ #category : #activity }
PjFileBasedBrowserBridgeClient >> openWebBrowserOn: appHtmlFileUrlString [
	WebBrowser
		openOn: self urlString
		inBackground: self openBrowserInBackground
]

{ #category : #accessing }
PjFileBasedBrowserBridgeClient >> urlString [
	^self appClass appHtmlUrlString
]

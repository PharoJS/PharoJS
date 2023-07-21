"
Utility trait to control the webbrowser
"
Trait {
	#name : #PjTWebBridgeClient,
	#instVars : [
		'openBrowserInBackground'
	],
	#category : #'PharoJs-Base-Bridge-Client-Kernel'
}

{ #category : #actions }
PjTWebBridgeClient >> openBrowserInBackground [

	^ openBrowserInBackground ifNil: [ false ]
]

{ #category : #actions }
PjTWebBridgeClient >> openBrowserInBackground: aBoolean [

	openBrowserInBackground := aBoolean
]

{ #category : #actions }
PjTWebBridgeClient >> openWebBrowserOn: urlString [

	WebBrowser
		openOn: urlString 
		inBackground: self openBrowserInBackground
]

{ #category : #initialization }
PjTWebBridgeClient >> reset [
	self sendMessage: PjMessageReload new.
	self resetProxiesImmediately.
	super reset
]

{ #category : #actions }
PjTWebBridgeClient >> sendMessage: aMessage [
	self bridge sendMessage: aMessage
]

{ #category : #actions }
PjTWebBridgeClient >> startJsInterpreter [

	WebBrowser
		openOn: self urlString
		inBackground: self openBrowserInBackground
]

{ #category : #accessing }
PjTWebBridgeClient >> urlString [

	self explicitRequirement
]

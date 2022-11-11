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

{ #category : #initialization }
PjTWebBridgeClient >> reset [
	self sendMessage: PjMessageReload new.
	super reset
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

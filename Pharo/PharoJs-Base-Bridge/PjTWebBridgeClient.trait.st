"
Utility trait to control the webbrowser
"
Trait {
	#name : 'PjTWebBridgeClient',
	#instVars : [
		'openBrowserInBackground'
	],
	#category : 'PharoJs-Base-Bridge-Client-Kernel',
	#package : 'PharoJs-Base-Bridge',
	#tag : 'Client-Kernel'
}

{ #category : 'initialization' }
PjTWebBridgeClient >> basicReset [

	self resetProxiesImmediately.
	self sendMessage: PjMessageReload new
]

{ #category : 'actions' }
PjTWebBridgeClient >> openBrowserInBackground [

	^ openBrowserInBackground ifNil: [ false ]
]

{ #category : 'actions' }
PjTWebBridgeClient >> openBrowserInBackground: aBoolean [

	openBrowserInBackground := aBoolean
]

{ #category : 'actions' }
PjTWebBridgeClient >> openWebBrowserOn: urlString [

	PjWebBrowser
		openOn: urlString 
		inBackground: self openBrowserInBackground
]

{ #category : 'actions' }
PjTWebBridgeClient >> sendMessage: aMessage [
	self bridge sendMessage: aMessage
]

{ #category : 'actions' }
PjTWebBridgeClient >> startJsInterpreter [

	PjWebBrowser
		openOn: self urlString
		inBackground: self openBrowserInBackground
]

{ #category : 'accessing' }
PjTWebBridgeClient >> urlString [

	self explicitRequirement
]

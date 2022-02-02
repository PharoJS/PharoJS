"
Utility trait to control the webbrowser
"
Trait {
	#name : #PjTBrowserController,
	#instVars : [
		'openBrowserInBackground'
	],
	#category : #'PharoJs-Base-Bridge-Client-Kernel'
}

{ #category : #actions }
PjTBrowserController >> openBrowserInBackground [

	^ openBrowserInBackground ifNil: [ false ]
]

{ #category : #actions }
PjTBrowserController >> openBrowserInBackground: aBoolean [

	openBrowserInBackground := aBoolean
]

{ #category : #actions }
PjTBrowserController >> startJsInterpreter [

	WebBrowser
		openOn: self urlString
		inBackground: self openBrowserInBackground
]

{ #category : #accessing }
PjTBrowserController >> urlString [

	self explicitRequirement
]

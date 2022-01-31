Trait {
	#name : #PjTBrowserController,
	#instVars : [
		'openBrowserInBackground'
	],
	#category : #'PharoJsBridge-Client-Kernel'
}

{ #category : #accessing }
PjTBrowserController >> openBrowserInBackground [
	^ openBrowserInBackground ifNil: [ false ]
]

{ #category : #accessing }
PjTBrowserController >> openBrowserInBackground: aBoolean [
	openBrowserInBackground := aBoolean
]

{ #category : #activity }
PjTBrowserController >> startJsInterpreter [
	WebBrowser
		openOn: self urlString
		inBackground: self openBrowserInBackground
]

{ #category : #accessing }
PjTBrowserController >> urlString [
	self explicitRequirement
]

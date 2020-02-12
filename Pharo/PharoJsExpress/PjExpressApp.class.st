"
A PjApplication for web servers using the popular web framework express.js

Uses the class PjExpressPolyfill to create an express server.

"
Class {
	#name : #PjExpressApp,
	#superclass : #PjNodeApplication,
	#instVars : [
		'expressServer'
	],
	#pools : [
		'PjExpressPolyfill'
	],
	#category : #PharoJsExpress
}

{ #category : #webapp }
PjExpressApp >> getRequest: path json: text [
	| a json |
	a := PjClass new.
	json := a newFromJsonString: text.
	expressServer get: path action: [ :req :res | res json: json ].
]

{ #category : #webapp }
PjExpressApp >> getRequest: path send: text [
	expressServer get: path action: [ :req :res | res send: text ].
]

{ #category : #webapp }
PjExpressApp >> listen: port [
	expressServer listen: port anon: [ PjCore log: 'listening on port ' + port ].
	
]

{ #category : #'start-stop' }
PjExpressApp >> start [
	expressServer := ExpressServer new.
	^ expressServer.
]

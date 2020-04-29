"
A PjApplication for web servers using the popular web framework express.js (https://expressjs.com/)

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
PjExpressApp >> getRequest: path json: json [
	expressServer get: path action: [ :req :res | res json: json ].
]

{ #category : #webapp }
PjExpressApp >> getRequest: path send: obj [
	expressServer get: path action: [ :req :res | res send: obj ].
]

{ #category : #webapp }
PjExpressApp >> listen: port [
	expressServer listen: port anon: [ Object log: 'listening on port ' + port ].
	
]

{ #category : #webapp }
PjExpressApp >> postRequest: path response: logic [
	expressServer post: path action: logic.
]

{ #category : #'start-stop' }
PjExpressApp >> start [
	expressServer := ExpressServer new.
	^ expressServer.
]

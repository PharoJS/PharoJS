"
A PjApplication for web servers using the popular web framework express.js (https://expressjs.com/)

Uses the class PjExpressPolyfill to create an express server.

"
Class {
	#name : #PjExpressApp,
	#superclass : #PjNodeApplication,
	#instVars : [
		'server'
	],
	#pools : [
		'PjExpressPolyfill'
	],
	#category : #PharoJsExpress
}

{ #category : #webapp }
PjExpressApp >> getRequest: path json: json [
	server get: path action: [ :req :res | res json: json ].
]

{ #category : #webapp }
PjExpressApp >> getRequest: path send: obj [
	server get: path action: [ :req :res | res send: obj ].
]

{ #category : #webapp }
PjExpressApp >> listen: port [
	server listen: port anon: [ Object log: 'listening on port ' + port ].
	
]

{ #category : #'start-stop' }
PjExpressApp >> port [
	^ 3000
]

{ #category : #webapp }
PjExpressApp >> postRequest: path response: logic [
	server post: path action: logic.
]

{ #category : #'start-stop' }
PjExpressApp >> setupPaths [
   self subclassResponsibility
]

{ #category : #'start-stop' }
PjExpressApp >> start [
   server := ExpressServer new.
   self setupPaths.
   self listen: self port.
]

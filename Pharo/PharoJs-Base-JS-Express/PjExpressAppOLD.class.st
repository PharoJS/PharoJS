"
A PjApplication for web servers using the popular web framework express.js (https://expressjs.com/)

Uses the class PjExpressPolyfill to create an express server.

"
Class {
	#name : #PjExpressAppOLD,
	#superclass : #PjNodeApplication,
	#instVars : [
		'server'
	],
	#pools : [
		'PjExpressPolyfill'
	],
	#category : #'PharoJs-Base-JS-Express'
}

{ #category : #webapp }
PjExpressAppOLD >> getRequest: path json: json [
	server get: path action: [ :req :res | res json: json ].
]

{ #category : #webapp }
PjExpressAppOLD >> getRequest: path send: obj [
	server get: path action: [ :req :res | res send: obj ].
]

{ #category : #webapp }
PjExpressAppOLD >> listen: port [
	server listen: port anon: [ Object log: 'listening on port ' + port ].
	
]

{ #category : #'start-stop' }
PjExpressAppOLD >> port [
	^ 3000
]

{ #category : #webapp }
PjExpressAppOLD >> postRequest: path response: logic [
	server post: path action: logic.
]

{ #category : #'start-stop' }
PjExpressAppOLD >> setupPaths [
   self subclassResponsibility
]

{ #category : #'start-stop' }
PjExpressAppOLD >> start [
   server := ExpressServer new.
   self setupPaths.
   self listen: self port.
]

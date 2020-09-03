"
A PjLoggingEvaluatorWebSocketDelegate is websocket wrapper that logs the web socket activity. It is run on the client side typically for debug and test purpose.

In production, the code of this class is translated to javascript and run on the client side.


Instance Variables
	logElementId:		<String>

logElementId
	- ID of the element in which logs are written

"
Class {
	#name : #PjLoggingEvaluatorWebsocketDelegate,
	#superclass : #PjEvaluatorWebsocketDelegate,
	#instVars : [
		'logElementId'
	],
	#classInstVars : [
		'logElementId'
	],
	#category : #'PharoJsBridge-Client-WebSocketDelegate'
}

{ #category : #'instance creation' }
PjLoggingEvaluatorWebsocketDelegate class >> logElementId [
	^ logElementId ifNil: [ 'webSocketLog' ]
]

{ #category : #'instance creation' }
PjLoggingEvaluatorWebsocketDelegate class >> logElementId: aString [
	logElementId := aString
]

{ #category : #logging }
PjLoggingEvaluatorWebsocketDelegate >> log: aString [
	| logElement br text |
 	[
		br := document createElement: 'BR'.
		text := document createTextNode: aString.
		logElement := self logElement.
		logElement
				insertBefore: br node: logElement firstChild;
				insertBefore: text node: logElement firstChild
	] on: Error do: [
		console log: aString
	]
]

{ #category : #logging }
PjLoggingEvaluatorWebsocketDelegate >> logElement [
	| logElement |
	logElement := document getElementById: self logElementId.
	logElement ifNil: [
		| enclosing |
		logElement := document createElement: 'DIV'.
		logElement
			appendChild: (document createElement: 'BR');
			id: self logElementId.
		enclosing := document createElement: 'DIV'.
		enclosing style
			backgroundColor: '#EEF';
			border: 'thin solid';
			padding: '1em'.
		enclosing
			appendChild: ((document createElement: 'H1')
									appendChild: (document createTextNode: 'Log of communications');
									yourself);
			appendChild: logElement.
		document body appendChild: enclosing
	].
	^ logElement
]

{ #category : #logging }
PjLoggingEvaluatorWebsocketDelegate >> logElementId [
	^ logElementId ifNil: [ logElementId := self class logElementId ]
]

{ #category : #logging }
PjLoggingEvaluatorWebsocketDelegate >> logElementId: anObject [
	logElementId := anObject
]

{ #category : #'socket behavior' }
PjLoggingEvaluatorWebsocketDelegate >> logReceived: aString [
	self log: 'Received: ', aString
]

{ #category : #'socket behavior' }
PjLoggingEvaluatorWebsocketDelegate >> logSent: aString [
	self log: 'Sent: ', aString.
	^ aString
]

{ #category : #'socket behavior' }
PjLoggingEvaluatorWebsocketDelegate >> onClose: event [
	super onClose: event.
	self log: 'Closed.'
]

{ #category : #'socket behavior' }
PjLoggingEvaluatorWebsocketDelegate >> onError: event [
	super onError: event.
	self log: 'Error.'
]

{ #category : #'socket behavior' }
PjLoggingEvaluatorWebsocketDelegate >> onOpen: event [
	super onOpen: event.
	self log: 'Open (id: ' , self id , ')'
]

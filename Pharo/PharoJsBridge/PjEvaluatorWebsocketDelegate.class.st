"
A PjEvaluatorWebSocketDelegate is a wrapper for websocket that evaluates received JavaScript code (see onMessage: ). It allows the bridge to control the client (see PjBridge>>#eval:).

In production, the code of this class is translated to javascript and run on the client side.



"
Class {
	#name : #PjEvaluatorWebsocketDelegate,
	#superclass : #PjWebsocketDelegate,
	#instVars : [
		'bridgeUrlString',
		'shouldRetryToConnectToServer'
	],
	#classInstVars : [
		'default'
	],
	#category : #'PharoJsBridge-Client-WebSocketDelegate'
}

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> closeDefault [
	self default close.

]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> connectDefaultToTag: tagString [ 
	| newInstance |
	newInstance := self connectToTag: tagString.
	self default: newInstance 
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> connectDefaultToUrl: urlString [
	| newInstance |
	newInstance := self connectToUrl: urlString.
	self default: newInstance 
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> default [
	^default
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> default: newInstance [
	default := newInstance.

]

{ #category : #constants }
PjEvaluatorWebsocketDelegate class >> includeClasses [
	^ {PhxJsonReader.
	PjMessageDeleteGlobalVar.
	PjMessageEvaluateJavascript.
	PjMessageGetKeys.
	PjMessageReload.
	PjMessageTerminate}
]

{ #category : #'class initialization' }
PjEvaluatorWebsocketDelegate class >> initialize [
	<javascript: 'this.pj_initializePrivate()'>
	
]

{ #category : #'class initialization' }
PjEvaluatorWebsocketDelegate class >> initializePrivate [

	#(JSON Math WebSocket console global document history location navigator screen window localStorage module process require)
		do: [ :each | 
			(global at: each)
				ifNotNil: [ :obj | obj instVarNamed: PjProxyManager oidVarName putHidden: each ] ]
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> reload [
	self reload: true.
	
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> reload: aBoolean [
	self closeDefault.
	"Reload parameter specifies the type of reloading:
false - Default. Reloads the current page from the cache.
true - Reloads the current page from the server."
	location reload: aBoolean.
	
]

{ #category : #'proxy support' }
PjEvaluatorWebsocketDelegate class >> set: anObject callback: trigger to: callback [
<PhxTicket: 'T#000322' name: 'Refactoring ParoJs PjBridge'>
	| fullTriggerName oldCallback |
	fullTriggerName := 'on' , trigger.
	oldCallback := anObject instVarNamed: fullTriggerName.
	anObject instVarNamed: fullTriggerName put: callback.
	callback
		ifNotNil: [ (callback hasOwnProperty: '$PjRefCount')
				ifTrue: [ | currRefCnt |
					currRefCnt := callback instVarNamed: '$PjRefCount'.
					callback instVarNamed: '$PjRefCount' put: currRefCnt + 1 ] ].
	oldCallback
		ifNotNil: [ | currRefCnt |
			currRefCnt := oldCallback instVarNamed: '$PjRefCount'.
			currRefCnt > 0
				ifTrue: [ oldCallback instVarNamed: '$PjRefCount' put: currRefCnt - 1.
					(oldCallback instVarNamed: '$PjRefCount') == 0
						ifTrue: [ oldCallback instVarNamed: '$PjProxyRemove' put: true.
							^ oldCallback ] ] ].
	^ true
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> terminate [ 
	[ self closeDefault ]
		on: Error
		do: [  ].
	[ process exit ]
		on: Error
		do: [  ]
]

{ #category : #connecting }
PjEvaluatorWebsocketDelegate >> close [
	shouldRetryToConnectToServer := false.
	super close
]

{ #category : #connecting }
PjEvaluatorWebsocketDelegate >> connectTo: urlString [
	shouldRetryToConnectToServer := true.
	bridgeUrlString := urlString.
	super connectTo: urlString
]

{ #category : #'initialize-release' }
PjEvaluatorWebsocketDelegate >> initialize [
	super initialize.
	Object prototype instVarNamed: PjCore pharoJsSelectorPrefix, 'inspect' putHidden: self makeInspect.

]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> logReceived: aString [
	console log: 'Received: ',aString
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> logSent: aString [
	console log: 'Sent: ',aString
]

{ #category : #'initialize-release' }
PjEvaluatorWebsocketDelegate >> makeInspect [
	^ self
		passJsThisArgumentToBlock: [ :this | 
			self
				tryToSendMessage:
					(PjMessageInspect newWithId
						subjectProxyInfo: this proxyResponse;
						yourself) ]
]

{ #category : #connecting }
PjEvaluatorWebsocketDelegate >> onClose: event [
	self reconnect
]

{ #category : #connecting }
PjEvaluatorWebsocketDelegate >> onError: event [
	self reconnect
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> onMessage: event [
	| jsonString msg |
	jsonString := event data.
	msg := PhxJsonReader readFromString: jsonString.
	self logReceived: msg logDescription.
	msg evaluateInContext: self newMessageContext
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> onOpen: event [
	super onOpen: event.
	self
		tryToSendMessage:
			(PjMessageSetClientId newWithId
				clientId: self id;
				yourself)
]

{ #category : #'initialize-release' }
PjEvaluatorWebsocketDelegate >> passJsThisArgumentToBlock: aBlock [
"Maybe this method should be moved to PjCore?"
	<javascript: 'return function(){aBlock(this)}'>
	
]

{ #category : #connecting }
PjEvaluatorWebsocketDelegate >> reconnect [
	shouldRetryToConnectToServer ifFalse: [^ self ].
	super connectTo: bridgeUrlString
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> tryToSendMessage: aMessage [
	self isClosed
		ifTrue: [ self logSent: 'Failed to send (websocket closed): ' , aMessage logDescription ]
		ifFalse: [ webSocket send: aMessage asPhxJsonString.
			self logSent: aMessage logDescription ]
]

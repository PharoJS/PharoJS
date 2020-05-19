"
A PjWebSocketDelegate is a wrapper for a JavaScript websocket. It provides entry points for subclasses to perform some actions during the websocket lifecycle 

In production, the code of this class is translated to javascript and run on the client side.

Instance Variables
	webSocket:		<JavaScript WebSocket>

webSocket
	- WebSocket created at the JavaScript client side

"
Class {
	#name : #PjWebsocketDelegate,
	#superclass : #PjObject,
	#instVars : [
		'webSocket',
		'id'
	],
	#pools : [
		'PjNodeGlobals'
	],
	#category : #'PharoJsBridge-Client-WebSocketDelegate'
}

{ #category : #'instance creation' }
PjWebsocketDelegate class >> connectToTag: tagString [
	^self connectToUrl: 'ws://', (location host), '/', tagString
]

{ #category : #'instance creation' }
PjWebsocketDelegate class >> connectToUrl: urlString [
	| newInstance |
	newInstance := self new.
	newInstance connectTo: urlString.
	^ newInstance
]

{ #category : #'as yet unclassified' }
PjWebsocketDelegate class >> new [
	^ super new
		id: self randomIdForNewInstance;
		yourself
]

{ #category : #'instance creation' }
PjWebsocketDelegate class >> randomIdForNewInstance [
	| charPool id size |
	charPool := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'.
	size := charPool size.
	id := ''.
	10
		timesRepeat: [ | rndIdx |
			rndIdx := (Math floor: Math random * size) + 1.
			id := id , (charPool at: rndIdx) ].
	^ id
]

{ #category : #connecting }
PjWebsocketDelegate >> close [
	webSocket close
]

{ #category : #connecting }
PjWebsocketDelegate >> connectTo: urlString [
	webSocket := WebSocket new: urlString.
	self initWebSocket
]

{ #category : #accessing }
PjWebsocketDelegate >> id [
	^ id
]

{ #category : #accessing }
PjWebsocketDelegate >> id: anObject [
	id := anObject
]

{ #category : #connecting }
PjWebsocketDelegate >> initWebSocket [
	webSocket instVarNamed:#onopen put: [: event | self onOpen: event].
	webSocket instVarNamed:#onmessage put: [: event | self onMessage: event]..
	webSocket instVarNamed:#onclose put: [: event | self onClose: event].
	webSocket instVarNamed:#onerror put: [: event | self onError: event].
]

{ #category : #'initialize-release' }
PjWebsocketDelegate >> initialize [
	super initialize.
	id := self class randomIdForNewInstance.
]

{ #category : #testing }
PjWebsocketDelegate >> isClosed [
	webSocket ifNil: [ ^true ].
	^ webSocket readyState == WebSocket CLOSED
]

{ #category : #testing }
PjWebsocketDelegate >> isConnected [
	webSocket ifNil: [ ^false ].
	^webSocket readyState == WebSocket OPEN
]

{ #category : #private }
PjWebsocketDelegate >> newMessageContext [
	| mc |
	mc := PjMessageContext new.
	mc websocketDelegate: self.
	^mc
]

{ #category : #'socket behavior' }
PjWebsocketDelegate >> onClose: event [
	^self
]

{ #category : #'socket behavior' }
PjWebsocketDelegate >> onError: event [
	^self
]

{ #category : #'socket behavior' }
PjWebsocketDelegate >> onMessage: event [
	^self
]

{ #category : #'socket behavior' }
PjWebsocketDelegate >> onOpen: event [
	^self
]

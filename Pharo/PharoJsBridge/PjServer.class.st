"
A PjServer is a server that manages a websocket used by the bridge to run/control javascript code on the client

Instance Variables
	timing:		<Object>
	webSocket:		<ZnWebSocket>

"
Class {
	#name : #PjServer,
	#superclass : #ZnSingleThreadedServer,
	#instVars : [
		'timing',
		'webSocket'
	],
	#classVars : [
		'LastUsedPort'
	],
	#category : #'PharoJsBridge-Kernel'
}

{ #category : #accessing }
PjServer class >> webSocketUrlTag [
	^'javascript-bridge'
]

{ #category : #'request handling' }
PjServer >> basicExecutePlainRequest: request sendResponseThrough: stream [
	|  response |
	ZnCurrentServer
		value: self
		during: [ 
			response := self handleRequest: request timing: timing.
			response setConnectionClose.
			self writeResponse: response on: stream timing: timing ]
]

{ #category : #accessing }
PjServer >> css [
	^self delegate css
]

{ #category : #accessing }
PjServer >> css: jsString [
	self delegate css: jsString
]

{ #category : #'initialize-release' }
PjServer >> delegateClass [
	^PjParametrizableServerDelegate
]

{ #category : #public }
PjServer >> ensureProcessAlive [
	self isProcessDead ifFalse: [ ^self ].
	super start
]

{ #category : #'request handling' }
PjServer >> executePlainRequest: request sendReponseThrough: stream and: socket [
[ 
	[ self basicExecutePlainRequest: request sendResponseThrough: stream ]
		ensure: [ 
			self logConnectionClosed: stream.
			stream close ] ]
		ifCurtailed: [ 
			self logServerGeneric: 'Destroying socket'.
			socket destroy ]

]

{ #category : #accessing }
PjServer >> favicon [
	^self delegate favicon
]

{ #category : #accessing }
PjServer >> favicon: jsString [
	self delegate favicon: jsString
]

{ #category : #accessing }
PjServer >> fingerPrint [
	^self delegate fingerPrint
]

{ #category : #'request handling' }
PjServer >> handleRequest: request forWebSocketOn: stream [
	| acceptKey  response |
	acceptKey := ZnWebSocketUtils handshake: (request headers at: 'Sec-WebSocket-Key').
	response := ZnWebSocketResponse new
		statusLine: (ZnStatusLine code: 101);
		headers: (self responseHeadersForKey: acceptKey);
		continuation:  [ :aWebSocket | webSocket := aWebSocket ].
	self augmentResponse: response forRequest: request.
	self writeResponse: response on: stream timing: timing.
	response useConnection: stream
		
]

{ #category : #accessing }
PjServer >> html [
	^self delegate html
]

{ #category : #accessing }
PjServer >> html: htmlString [
	self delegate html: htmlString
]

{ #category : #'initialize-release' }
PjServer >> initialize [
	super initialize.
	self delegate: self delegateClass new

]

{ #category : #testing }
PjServer >> isProcessDead [
	^self process isNil or: [ self process isTerminating or: [ self process isTerminated ]  ]
]

{ #category : #'initialize-release' }
PjServer >> isWebSocketConnected [
	self webSocket ifNil: [ ^ false ].
	^ self webSocket isConnected
]

{ #category : #accessing }
PjServer >> javascript [
	^self delegate javascript
]

{ #category : #accessing }
PjServer >> javascript: jsString [
	self delegate javascript: jsString
]

{ #category : #logging }
PjServer >> logSocketRead: aString [
	logLevel < 4 ifTrue: [ ^ self ].
	(self newLogEvent: PjSocketLogEvent)
		direction: 'read';
		contents: aString;
		emit.

]

{ #category : #logging }
PjServer >> logSocketWritten: aString [
	logLevel < 4 ifTrue: [ ^ self ].
	(self newLogEvent: PjSocketLogEvent)
		direction: 'wrote';
		contents: aString;
		emit.

]

{ #category : #logging }
PjServer >> loggingOn [
	logLevel := 4 " extended for websocket tracking "
]

{ #category : #accessing }
PjServer >> maxPortNumber [
	^65535
]

{ #category : #accessing }
PjServer >> minPortNumber [
	^1024
]

{ #category : #accessing }
PjServer >> nextPortNumber [
	LastUsedPort ifNil: [ ^LastUsedPort := self minPortNumber ].
	LastUsedPort = self maxPortNumber ifTrue: [^LastUsedPort := self minPortNumber].
	LastUsedPort := LastUsedPort + 1.
	^LastUsedPort
]

{ #category : #'request handling' }
PjServer >> responseHeadersForKey: key [
	"Return the headers for a WebSocket setup response, given key"
	
	^ ZnHeaders defaultResponseHeaders
			at: 'Upgrade' put: 'websocket';
			at: 'Connection' put: 'Upgrade';
			at: 'Sec-WebSocket-Accept' put: key;
			yourself
]

{ #category : #public }
PjServer >> restart [
<PhxTicket: 'T#000322' name: 'Refactoring ParoJs PjBridge'>
	self stop.
	super start
]

{ #category : #'request handling' }
PjServer >> serveConnectionOn: listeningSocket [
	"We wait up to acceptWaitTimeout seconds for an incoming connection.
	If we get one we wrap it in a SocketStream and #executeOneRequestResponseOn: on it.
	We do not fork a worker thread/process but stay in the current one for just one request/response cycle."

	|  socket stream request |
	socket := listeningSocket waitForAcceptFor: self acceptWaitTimeout.
	socket ifNil: [ ^ self noteAcceptWaitTimedOut ].
	stream := self socketStreamOn: socket.
	timing := ZnServerTransactionTiming new.
	request := self readRequest: stream timing: timing.
	(request relativeUrl path endsWith: self webSocketUrlTag) ifTrue: [
		^self handleRequest: request forWebSocketOn: stream].
	self executePlainRequest: request sendReponseThrough: stream and: socket
]

{ #category : #public }
PjServer >> start [
	| candidatePort usedPorts |
	candidatePort := self nextPortNumber.
	usedPorts := (self class allInstances select: #isRunning thenCollect: #port) asSet.
	[ usedPorts includes: candidatePort ] whileTrue: [candidatePort := self nextPortNumber].
	self startOnPort: candidatePort
]

{ #category : #public }
PjServer >> startOnPort: aPort [
	self port: aPort.
	super start
]

{ #category : #public }
PjServer >> stop [
	self stopWebSocket.
	super stop
]

{ #category : #'initialize-release' }
PjServer >> stopWebSocket [
	self webSocket ifNil: [ ^self ].
	self webSocket isConnected ifFalse: [ ^self ].
	[
		self webSocket close
	] on: ConnectionTimedOut do: [ " nothing: the socket's gone away " ]
]

{ #category : #accessing }
PjServer >> urlString [
	^self url asString
]

{ #category : #accessing }
PjServer >> webSocket [
	^webSocket
]

{ #category : #accessing }
PjServer >> webSocketUrlTag [
	^self class webSocketUrlTag 
]

Class {
	#name : #PjBridgeServer,
	#superclass : #Object,
	#instVars : [
		'timing',
		'html',
		'javascript',
		'css',
		'favicon',
		'fingerPrint',
		'znServer',
		'webSocket',
		'bridge'
	],
	#classVars : [
		'CurrentUsablePortNumber'
	],
	#category : #'PharoJsBridge-Kernel'
}

{ #category : #accessing }
PjBridgeServer class >> currentUsablePortNumber [
	
	^CurrentUsablePortNumber
]

{ #category : #accessing }
PjBridgeServer class >> currentUsablePortNumber: aNumber [
	CurrentUsablePortNumber := aNumber
]

{ #category : #accessing }
PjBridgeServer class >> incrementCurrentUsablePortNumber [
	| p |
	p := self currentUsablePortNumber
		ifNotNil: [ :cp | cp + 1 ]
		ifNil: [ self minPortNumber ].
	p > self maxPortNumber
		ifTrue: [ p := self minPortNumber ].
	self currentUsablePortNumber: p
]

{ #category : #accessing }
PjBridgeServer class >> maxPortNumber [
	^65535
]

{ #category : #accessing }
PjBridgeServer class >> minPortNumber [
	^1024
]

{ #category : #accessing }
PjBridgeServer class >> webSocketUrlTag [
	^'javascript-bridge'
]

{ #category : #accessing }
PjBridgeServer >> bridge [
	^ bridge
]

{ #category : #accessing }
PjBridgeServer >> bridge: anObject [
	bridge := anObject
]

{ #category : #accessing }
PjBridgeServer >> css [
	^ css
]

{ #category : #accessing }
PjBridgeServer >> css: anObject [
	css := anObject
]

{ #category : #accessing }
PjBridgeServer >> favicon [
	^ favicon
]

{ #category : #accessing }
PjBridgeServer >> favicon: anObject [
	favicon := anObject
]

{ #category : #accessing }
PjBridgeServer >> fingerPrint [
	^ fingerPrint
]

{ #category : #accessing }
PjBridgeServer >> fingerPrint: anObject [
	fingerPrint := anObject
]

{ #category : #websocket }
PjBridgeServer >> handleMessage: rawSocketMessage forSocket: aWebSocket [
	self bridge acceptIncomingMessageFromClient: (PhxJsonReader readFromString: rawSocketMessage)
]

{ #category : #accessing }
PjBridgeServer >> html [
	^ html
]

{ #category : #accessing }
PjBridgeServer >> html: anObject [
	html := anObject
]

{ #category : #'initialize-release' }
PjBridgeServer >> indexHtmlResponse [
	^ ZnResponse ok: (ZnEntity html: self html)
]

{ #category : #'initialize-release' }
PjBridgeServer >> initialize [
	super initialize.
	znServer := self newDefaultZnServer.
	fingerPrint := UUIDGenerator next asString.
	
]

{ #category : #testing }
PjBridgeServer >> isStarted [
	^ self znServer isRunning and: [ self isStartedCheckExternally ]
]

{ #category : #testing }
PjBridgeServer >> isStartedCheckExternally [
	^ (ZnClient new
		timeout: 1;
		ifFail: [ String new ];
		get:
			'http://localhost:' , self znServer port asString
				, '/serverFingerPrint') = self fingerPrint
]

{ #category : #start }
PjBridgeServer >> isStartedWithinTimeout [
	| attempts |
	attempts := 1.
	[ self isStarted
		ifTrue: [ ^ true ].
	attempts >= 10 ]
		whileFalse: [ 20 milliSeconds wait.
			attempts := attempts + 1 ].
	^ false
]

{ #category : #websocket }
PjBridgeServer >> isWebSocketConnected [
	^self webSocket notNil
]

{ #category : #accessing }
PjBridgeServer >> javascript [
	^ javascript
]

{ #category : #accessing }
PjBridgeServer >> javascript: anObject [
	javascript := anObject
]

{ #category : #logging }
PjBridgeServer >> logSocketRead: aString [
]

{ #category : #logging }
PjBridgeServer >> logSocketWritten: aString [
]

{ #category : #'initialize-release' }
PjBridgeServer >> newDefaultZnServer [
	| srv |
	srv := ZnMultiThreadedServer new.
	srv delegate: self newDefaultZnServerDelegate.
	^ srv
]

{ #category : #'initialize-release' }
PjBridgeServer >> newDefaultZnServerDelegate [
	| d |
	d := ZnDefaultServerDelegate empty.
	d map: '/' to: 'index.html'.
	d
		map: 'index.html'
		to: [ :request | ZnResponse ok: (ZnEntity html: self html) ].
	d
		map: 'index.js'
		to: [ :request | ZnResponse ok: (ZnEntity javascript: self javascript) ].
	d
		map: 'index.css'
		to: [ :request | ZnResponse ok: (ZnEntity css: self css) ].
	d
		map: 'favicon.ico'
		to: [ :request | 
			self favicon
				ifNil: [ ZnResponse notFound: request uri ]
				ifNotNil: [ ZnResponse ok: (ZnEntity favicon: self favicon) ] ].
	d
		map: 'serverFingerPrint'
		to: [ :request | ZnResponse ok: (ZnEntity text: self fingerPrint) ].
	d
		map: self webSocketUrlTag
		to: (ZnWebSocketDelegate map: self webSocketUrlTag to: self).
	^ d
]

{ #category : #public }
PjBridgeServer >> port: aPortNumber [
	self znServer port: aPortNumber
]

{ #category : #printing }
PjBridgeServer >> printOn: ws [
	super printOn: ws.
	ws << ' --> '.
	self znServer
		ifNil: [ 'znServer missing???' ]
		ifNotNil: [ :znSrv | znSrv printOn: ws ]
]

{ #category : #websocket }
PjBridgeServer >> safelyHandleMessage: aMessage forSocket: aWebSocket [
	[ self handleMessage: aMessage forSocket: aWebSocket ]
		on: Error
		do: [ :ex | 
			self halt.
			aWebSocket
				sendMessage:
					'Server says no: Invalid incoming message (Error: '
						, (ex description ifNilOrEmpty: [ 'Unkown reason' ]) , ')'.
			ex return ]
]

{ #category : #start }
PjBridgeServer >> start [
	| attempts |
	self isStarted
		ifTrue: [ ^ self ].
	attempts := 1.
	[ self startOnCurrentUsablePortNumber.
	self isStartedWithinTimeout ]
		whileFalse: [ attempts := attempts + 1.
			self class incrementCurrentUsablePortNumber ]
]

{ #category : #start }
PjBridgeServer >> startOnCurrentUsablePortNumber [
	self startOnPort: self class currentUsablePortNumber
]

{ #category : #start }
PjBridgeServer >> startOnPort: aPort [
	self isStarted
		ifTrue: [ ^ self ].
	self stop.
	self znServer
		port: aPort;
		start
]

{ #category : #stop }
PjBridgeServer >> stop [
	Logger log: 'Server stop'.
	self znServer stop
]

{ #category : #accessing }
PjBridgeServer >> timing [
self halt.
	^ timing
]

{ #category : #accessing }
PjBridgeServer >> timing: anObject [
self halt.
	timing := anObject
]

{ #category : #accessing }
PjBridgeServer >> url [
	^ self znServer url
]

{ #category : #accessing }
PjBridgeServer >> urlString [
	^self url asString
]

{ #category : #accessing }
PjBridgeServer >> value: aWebSocket [
	[ self webSocket: aWebSocket.
	aWebSocket
		runWith:
			[ :aMessage | Logger log: aMessage. self safelyHandleMessage: aMessage forSocket: aWebSocket ] ]
		on: Error
		do: [ self webSocket: nil ]	
]

{ #category : #accessing }
PjBridgeServer >> webSocket [
	^ webSocket
]

{ #category : #accessing }
PjBridgeServer >> webSocket: anObject [
	Logger log: anObject asString.
	webSocket := anObject
]

{ #category : #accessing }
PjBridgeServer >> webSocketUrlTag [
	^self class webSocketUrlTag 
]

{ #category : #accessing }
PjBridgeServer >> znServer [
	^ znServer
]

{ #category : #accessing }
PjBridgeServer >> znServer: anObject [
	znServer := anObject
]

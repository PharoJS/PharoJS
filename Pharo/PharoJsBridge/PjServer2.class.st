Class {
	#name : #PjServer2,
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
PjServer2 class >> currentUsablePortNumber [
	
	^CurrentUsablePortNumber
]

{ #category : #accessing }
PjServer2 class >> currentUsablePortNumber: aNumber [
	CurrentUsablePortNumber := aNumber
]

{ #category : #accessing }
PjServer2 class >> incrementCurrentUsablePortNumber [
	| p |
	p := self currentUsablePortNumber
		ifNotNil: [ :cp | cp + 1 ]
		ifNil: [ self minPortNumber ].
	p > self maxPortNumber
		ifTrue: [ p := self minPortNumber ].
	self currentUsablePortNumber: p
]

{ #category : #accessing }
PjServer2 class >> maxPortNumber [
	^65535
]

{ #category : #accessing }
PjServer2 class >> minPortNumber [
	^1024
]

{ #category : #accessing }
PjServer2 class >> webSocketUrlTag [
	^'javascript-bridge'
]

{ #category : #accessing }
PjServer2 >> bridge [
	^ bridge
]

{ #category : #accessing }
PjServer2 >> bridge: anObject [
	bridge := anObject
]

{ #category : #accessing }
PjServer2 >> css [
	^ css
]

{ #category : #accessing }
PjServer2 >> css: anObject [
	css := anObject
]

{ #category : #accessing }
PjServer2 >> ensureProcessAlive [
	
]

{ #category : #accessing }
PjServer2 >> favicon [
	^ favicon
]

{ #category : #accessing }
PjServer2 >> favicon: anObject [
	favicon := anObject
]

{ #category : #accessing }
PjServer2 >> fingerPrint [
	^ fingerPrint
]

{ #category : #accessing }
PjServer2 >> fingerPrint: anObject [
	fingerPrint := anObject
]

{ #category : #accessing }
PjServer2 >> handleMessage: rawSocketMessage forSocket: aWebSocket [
	self bridge acceptIncomingMessageFromClient: (PhxJsonReader readFromString: rawSocketMessage)
]

{ #category : #accessing }
PjServer2 >> html [
	^ html
]

{ #category : #accessing }
PjServer2 >> html: anObject [
	html := anObject
]

{ #category : #'initialize-release' }
PjServer2 >> initialize [
	super initialize.
	znServer := ZnMultiThreadedServer  new.
	fingerPrint := UUIDGenerator next asString.
	self initializeDelegate.
]

{ #category : #'initialize-release' }
PjServer2 >> initializeDelegate [
	znServer delegate: self newDelegate
]

{ #category : #testing }
PjServer2 >> isServerStarted [
	"compatibility for PjBridge class>>bridge (needed for debugging)"

	^ self isStarted
]

{ #category : #testing }
PjServer2 >> isServerStartedExtraCheck [
	^ (ZnClient new
		timeout: 1;
		ifFail: [ String new ];
		get:
			'http://localhost:' , self znServer port asString
				, '/serverFingerPrint') = self fingerPrint
]

{ #category : #testing }
PjServer2 >> isStarted [
	^ self znServer isRunning and: [ self isServerStartedExtraCheck ]
]

{ #category : #accessing }
PjServer2 >> isStartedWithinTimeout [
	| attempts |
	attempts := 1.
	[ self isStarted
		ifTrue: [ ^ true ].
	attempts >= 10 ]
		whileFalse: [ 20 milliSeconds wait.
			attempts := attempts + 1 ].
	^ false
]

{ #category : #testing }
PjServer2 >> isWebSocketConnected [
	^self webSocket notNil
]

{ #category : #accessing }
PjServer2 >> javascript [
	^ javascript
]

{ #category : #accessing }
PjServer2 >> javascript: anObject [
	javascript := anObject
]

{ #category : #logging }
PjServer2 >> logSocketRead: aString [
]

{ #category : #logging }
PjServer2 >> logSocketWritten: aString [
]

{ #category : #accessing }
PjServer2 >> newDelegate [
	| d |
	d := ZnDefaultServerDelegate empty.
	d map: '/' to: 'index.html'.
	self html
		ifNotNil: [ :str | 
			d
				map: 'index.html'
				to: [ :request | ZnResponse ok: (ZnEntity text: str) ] ].
	self javascript
		ifNotNil: [ :str | 
			d
				map: 'index.js'
				to: [ :request | ZnResponse ok: (ZnEntity text: str) ] ].
	self css
		ifNotNil: [ :str | 
			d
				map: 'index.css'
				to: [ :request | ZnResponse ok: (ZnEntity text: str) ] ].
	self favicon
		ifNotNil: [ :str | 
			d
				map: 'favicon.ico'
				to: [ :request | ZnResponse ok: (ZnEntity text: str) ] ].
	self fingerPrint
		ifNotNil: [ :str | 
			d
				map: 'serverFingerPrint'
				to: [ :request | ZnResponse ok: (ZnEntity text: str) ] ].
	d
		map: self webSocketUrlTag
		to: (ZnWebSocketDelegate map: self webSocketUrlTag to: self).
	^ d
]

{ #category : #accessing }
PjServer2 >> safelyHandleMessage: aMessage forSocket: aWebSocket [
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

{ #category : #accessing }
PjServer2 >> start [
	| attempts |
	attempts := 1.
	[ self startOnCurrentUsablePortNumber.
	self isStartedWithinTimeout ]
		whileFalse: [ attempts := attempts + 1.
			self class incrementCurrentUsablePortNumber ]
]

{ #category : #accessing }
PjServer2 >> startOnCurrentUsablePortNumber [
	self startOnPort: self class currentUsablePortNumber
]

{ #category : #accessing }
PjServer2 >> startOnPort: aPort [
	self znServer
		port: aPort;
		start
]

{ #category : #accessing }
PjServer2 >> stop [
	Logger log: 'Server stop'.
	self znServer stop
]

{ #category : #accessing }
PjServer2 >> timing [
	^ timing
]

{ #category : #accessing }
PjServer2 >> timing: anObject [
	timing := anObject
]

{ #category : #accessing }
PjServer2 >> url [
	^ self znServer url
]

{ #category : #accessing }
PjServer2 >> urlString [
	^self url asString
]

{ #category : #accessing }
PjServer2 >> value: aWebSocket [
	[ self webSocket: aWebSocket.
	aWebSocket
		runWith:
			[ :aMessage | Logger log: aMessage. self safelyHandleMessage: aMessage forSocket: aWebSocket ] ]
		on: Error
		do: [ self webSocket: nil ]	
]

{ #category : #accessing }
PjServer2 >> webSocket [
	^ webSocket
]

{ #category : #accessing }
PjServer2 >> webSocket: anObject [
	Logger log: anObject asString.
	webSocket := anObject
]

{ #category : #accessing }
PjServer2 >> webSocketUrlTag [
	^self class webSocketUrlTag 
]

{ #category : #accessing }
PjServer2 >> znServer [
	^ znServer
]

{ #category : #accessing }
PjServer2 >> znServer: anObject [
	znServer := anObject
]

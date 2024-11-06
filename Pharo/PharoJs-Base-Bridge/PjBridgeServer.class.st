Class {
	#name : 'PjBridgeServer',
	#superclass : 'Object',
	#instVars : [
		'timing',
		'html',
		'javascript',
		'css',
		'favicon',
		'fingerPrint',
		'znServer',
		'webSocket',
		'bridge',
		'childProcesses'
	],
	#classVars : [
		'CurrentUsablePortNumber'
	],
	#category : 'PharoJs-Base-Bridge-Kernel',
	#package : 'PharoJs-Base-Bridge',
	#tag : 'Kernel'
}

{ #category : 'accessing' }
PjBridgeServer class >> currentUsablePortNumber [

	CurrentUsablePortNumber ifNil: [ 
		CurrentUsablePortNumber := self minPortNumber ].
	^ CurrentUsablePortNumber
]

{ #category : 'accessing' }
PjBridgeServer class >> currentUsablePortNumber: aNumber [

	CurrentUsablePortNumber := aNumber
]

{ #category : 'accessing' }
PjBridgeServer class >> incrementCurrentUsablePortNumber [

	| p |
	p := self currentUsablePortNumber
		     ifNotNil: [ :cp | cp + 1 ]
		     ifNil: [ self minPortNumber ].
	p > self maxPortNumber ifTrue: [ p := self minPortNumber ].
	self currentUsablePortNumber: p
]

{ #category : 'accessing' }
PjBridgeServer class >> maxPortNumber [

	^ 65535
]

{ #category : 'accessing' }
PjBridgeServer class >> minPortNumber [

	^ 1024
]

{ #category : 'accessing' }
PjBridgeServer class >> webSocketUrlTag [

	^ 'javascript-bridge'
]

{ #category : 'accessing' }
PjBridgeServer >> bridge [
	^ bridge
]

{ #category : 'accessing' }
PjBridgeServer >> bridge: anObject [
	bridge := anObject
]

{ #category : 'accessing' }
PjBridgeServer >> childProcesses [

	^ childProcesses ifNil: [ childProcesses := WeakIdentitySet new ]
]

{ #category : 'accessing' }
PjBridgeServer >> css [
	^ css ifNil: [ '' ]
]

{ #category : 'accessing' }
PjBridgeServer >> css: anObject [
	css := anObject
]

{ #category : 'accessing' }
PjBridgeServer >> defaultHTML [
	^'<!DOCTYPE html>
<html>
<head>
    <title>PharoJS - Develop in Pharo, Run on JavaScript</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .container {
            text-align: center;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 28px;
            color: #333333;
        }

        p {
            font-size: 16px;
            color: #666666;
            margin-bottom: 20px;
        }

        a {
            color: #0066cc;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>PharoJS - Develop in Pharo, Run on JavaScript</h1>
        <p>Thank you for being a part of the PharoJS community. We appreciate your dedication to developing in Pharo and running your applications on JavaScript.</p>
        <p>PharoJS is open-source under the MIT License. You can find the source code on <a href="https://github.com/PharoJS/PharoJS" target="_blank">GitHub</a>.</p>
        <p>Visit <a href="https://pharojs.org" target="_blank">PharoJS.org</a> to learn more and get started.</p>
    </div>
</body>
</html>
'
]

{ #category : 'accessing' }
PjBridgeServer >> delegate [

	^ znServer delegate
]

{ #category : 'accessing' }
PjBridgeServer >> delegate: znServerDelegate [ 
	znServer delegate: znServerDelegate 
]

{ #category : 'accessing' }
PjBridgeServer >> favicon [
	^ favicon
]

{ #category : 'accessing' }
PjBridgeServer >> favicon: anObject [
	favicon := anObject
]

{ #category : 'accessing' }
PjBridgeServer >> fingerPrint [
	^ fingerPrint
]

{ #category : 'accessing' }
PjBridgeServer >> fingerPrint: anObject [
	fingerPrint := anObject
]

{ #category : 'websocket' }
PjBridgeServer >> handleMessage: rawSocketMessage forSocket: aWebSocket [
	| msg |
	msg := PhxJsonReader readFromString: rawSocketMessage.
	self bridge acceptIncomingMessageFromClient: msg.
	self logSocketRead: msg logDescription
]

{ #category : 'accessing' }
PjBridgeServer >> html [
	^ html ifNil: [ self defaultHTML]
]

{ #category : 'accessing' }
PjBridgeServer >> html: anObject [
	html := anObject
]

{ #category : 'start' }
PjBridgeServer >> incrementCurrentUsablePortNumber [
	self class incrementCurrentUsablePortNumber
]

{ #category : 'initialization' }
PjBridgeServer >> indexHtmlResponse [
	^ ZnResponse ok: (ZnEntity html: self html)
]

{ #category : 'initialization' }
PjBridgeServer >> initialize [

	super initialize.
	znServer := self newZincServer.
	fingerPrint := UUID new asString
]

{ #category : 'testing' }
PjBridgeServer >> isStarted [
	^ self znServer isRunning and: [ self isStartedCheckExternally ]
]

{ #category : 'testing' }
PjBridgeServer >> isStartedCheckExternally [
	^ (ZnClient new
		timeout: 1;
		ifFail: [ String new ];
		get:
			'http://localhost:' , self znServer port asString
				, '/serverFingerPrint') = self fingerPrint
]

{ #category : 'start' }
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

{ #category : 'websocket' }
PjBridgeServer >> isWebSocketConnected [
	^self webSocket notNil
]

{ #category : 'accessing' }
PjBridgeServer >> javascript [
	^ javascript
]

{ #category : 'accessing' }
PjBridgeServer >> javascript: anObject [
	javascript := anObject
]

{ #category : 'logging' }
PjBridgeServer >> logSocketRead: aString [
	(self znServer newLogEvent: PjSocketLogEvent)
		direction: 'read';
		contents: aString;
		emit
]

{ #category : 'logging' }
PjBridgeServer >> logSocketWritten: aString [
	(self znServer newLogEvent: PjSocketLogEvent)
		direction: 'wrote';
		contents: aString;
		emit
]

{ #category : 'initialization' }
PjBridgeServer >> newServerDelegate [

	| newDelegate |
	newDelegate := PjBridgeServerDelegate empty.
	newDelegate map: '/' to: 'index.html'.
	newDelegate
		map: 'index.html'
		to: [ :request | ZnResponse ok: (ZnEntity html: self html) ].
	newDelegate
		map: 'index.js'
		to: [ :request | 
		ZnResponse ok: (ZnEntity javascript: self javascript) ].
	newDelegate
		map: 'index.css'
		to: [ :request | ZnResponse ok: (ZnEntity css: self css) ].
	newDelegate map: 'favicon.ico' to: [ :request | 
		self favicon
			ifNil: [ ZnResponse notFound: request uri ]
			ifNotNil: [ ZnResponse ok: (ZnEntity favicon: self favicon) ] ].
	newDelegate
		map: 'serverFingerPrint'
		to: [ :request | ZnResponse ok: (ZnEntity text: self fingerPrint) ].
	newDelegate
		map: self webSocketUrlTag
		to: (ZnWebSocketDelegate map: self webSocketUrlTag to: self).
	^ newDelegate
]

{ #category : 'initialization' }
PjBridgeServer >> newZincServer [

	| srv |
	srv := ZnMultiThreadedServer new.
	srv delegate: self newServerDelegate.
	^ srv
]

{ #category : 'accessing' }
PjBridgeServer >> port [

	^ self znServer port
]

{ #category : 'public' }
PjBridgeServer >> port: aPortNumber [

	self znServer port: aPortNumber
]

{ #category : 'printing' }
PjBridgeServer >> printOn: ws [

	super printOn: ws.
	ws << ' --> '.
	self znServer
		ifNil: [ 'znServer missing???' ]
		ifNotNil: [ :znSrv | znSrv printOn: ws ]
]

{ #category : 'websocket' }
PjBridgeServer >> safelyHandleMessage: aMessage forSocket: aWebSocket [

	[ self handleMessage: aMessage forSocket: aWebSocket ]
		on: Error
		do: [ :ex | 
			self halt.
			ex return ]
]

{ #category : 'start' }
PjBridgeServer >> start [

	"We change the current usable port number before starting to avoid collision with potentially other bridge servers. This happens sometimes in tests before bridges are garbageCollected"
	| attempts |
	self isStarted ifTrue: [ ^ self ].
	self incrementCurrentUsablePortNumber.
	attempts := 1.
	[
	self startOnCurrentUsablePortNumber.
	self isStartedWithinTimeout ] whileFalse: [
		attempts := attempts + 1.
		self incrementCurrentUsablePortNumber ]
]

{ #category : 'start' }
PjBridgeServer >> startOnCurrentUsablePortNumber [

	self startOnPort: self class currentUsablePortNumber
]

{ #category : 'start' }
PjBridgeServer >> startOnPort: aPort [

	self isStarted ifTrue: [ ^ self ].
	self stop.
	self znServer
		port: aPort;
		start
]

{ #category : 'stop' }
PjBridgeServer >> stop [

	self znServer ifNotNil: [ :srv | srv stop ].
	self childProcesses do: [ :each | each terminate ].
	childProcesses := nil.
	Smalltalk garbageCollect
]

{ #category : 'accessing' }
PjBridgeServer >> tearDown [

	self stop.
	self bridge: nil
]

{ #category : 'accessing' }
PjBridgeServer >> timing [

	self halt.
	^ timing
]

{ #category : 'accessing' }
PjBridgeServer >> timing: anObject [

	self halt.
	timing := anObject
]

{ #category : 'accessing' }
PjBridgeServer >> url [

	^ self znServer url
]

{ #category : 'accessing' }
PjBridgeServer >> urlString [

	^ self url asString
]

{ #category : 'accessing' }
PjBridgeServer >> value: aWebSocket [

	self childProcesses add: Processor activeProcess.
	[
	self webSocket: aWebSocket.
	aWebSocket runWith: [ :aMessage |
		self safelyHandleMessage: aMessage forSocket: aWebSocket ] ]
		on: Error
		do: [  ]
]

{ #category : 'accessing' }
PjBridgeServer >> webSocket [

	^ webSocket
]

{ #category : 'accessing' }
PjBridgeServer >> webSocket: anObject [

	webSocket := anObject
]

{ #category : 'accessing' }
PjBridgeServer >> webSocketUrlTag [

	^ self class webSocketUrlTag
]

{ #category : 'accessing' }
PjBridgeServer >> znServer [

	^ znServer
]

{ #category : 'accessing' }
PjBridgeServer >> znServer: anObject [

	znServer := anObject
]

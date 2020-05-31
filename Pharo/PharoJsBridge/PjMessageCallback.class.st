Class {
	#name : #PjMessageCallback,
	#superclass : #PjMessageC2s,
	#instVars : [
		'receiverProxyInfo',
		'eventProxyInfo',
		'eventTargetProxyInfo'
	],
	#category : #'PharoJsBridge-Messages'
}

{ #category : #accessing }
PjMessageCallback >> eventProxyInfo [
	^ eventProxyInfo
]

{ #category : #accessing }
PjMessageCallback >> eventProxyInfo: anObject [
	eventProxyInfo := anObject
]

{ #category : #accessing }
PjMessageCallback >> eventTargetProxyInfo [
	^ eventTargetProxyInfo
]

{ #category : #accessing }
PjMessageCallback >> eventTargetProxyInfo: anObject [
	eventTargetProxyInfo := anObject
]

{ #category : #testing }
PjMessageCallback >> isCallback [
	^ true
]

{ #category : #printing }
PjMessageCallback >> logDescription [
	^ String
		streamContents: [ :ws | 
			ws nextPutAll: self class name.
			ws nextPutAll: ' id: '.
			ws nextPutAll: self id asString.
			ws space.
			self printDetailsOn: ws ]
]

{ #category : #printing }
PjMessageCallback >> printDetailsOn: ws [
	ws nextPutAll: ' rcvr: '.
	ws
		nextPutAll:
			(self receiverProxyInfo
				ifNotNil: [ :pi | pi logDescription ]
				ifNil: [ '-' ]).
	ws nextPutAll: ' event: '.
	ws
		nextPutAll:
			(self eventProxyInfo
				ifNotNil: [ :pi | pi logDescription ]
				ifNil: [ '-' ])
]

{ #category : #printing }
PjMessageCallback >> printOn: ws [
	<pharoJsSkip>
	super printOn: ws.
	ws space.
	self printDetailsOn: ws
]

{ #category : #public }
PjMessageCallback >> processCallbackWithBridge: aBridge [
	<pharoJsSkip>
	| proxy eventProxy eventTargetProxy |
	proxy := self receiverProxyInfo proxyForBridge: aBridge.
	eventProxy := self eventProxyInfo proxyForBridge: aBridge.
	eventTargetProxy := (self eventTargetProxyInfo ifNotNil: [:pi | pi proxyForBridge: aBridge]).
	proxy runBlockClosure: eventProxy  with: eventTargetProxy
]

{ #category : #accessing }
PjMessageCallback >> receiverProxyInfo [
	^ receiverProxyInfo
]

{ #category : #accessing }
PjMessageCallback >> receiverProxyInfo: anObject [
	receiverProxyInfo := anObject
]

Class {
	#name : #PjProxyInfo,
	#superclass : #Object,
	#instVars : [
		'remove',
		'oid',
		'globalName'
	],
	#pools : [
		'PjNodeGlobals'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #public }
PjProxyInfo >> getJsObject [
	^ global instVarNamed: self globalName
]

{ #category : #accessing }
PjProxyInfo >> globalName [
	^ globalName
]

{ #category : #accessing }
PjProxyInfo >> globalName: anObject [
	globalName := anObject
]

{ #category : #printing }
PjProxyInfo >> logDescription [
	^ String
		streamContents: [ :ws | 
			ws nextPutAll: 'Proxy '.
			ws nextPutAll: ' oid: '.
			ws nextPutAll: self oid.
			ws nextPutAll: ' globalName: '.
			ws nextPutAll: self globalName.
			ws nextPutAll: ' remove: '.
			ws
				nextPutAll:
					(self remove == true
						ifTrue: [ 'true' ]
						ifFalse: [ 'false' ]) ]
]

{ #category : #accessing }
PjProxyInfo >> oid [
	^ oid
]

{ #category : #accessing }
PjProxyInfo >> oid: anObject [
	oid := anObject
]

{ #category : #public }
PjProxyInfo >> proxyForBridge: aBridge [
	"jsName globalRef"

	<pharoJsSkip>
	| proxy |
	self globalName = #undefined
		ifTrue: [ ^ nil ].
	self globalName = #null
		ifTrue: [ ^ nil ].
	self remove == true
		ifTrue: [ aBridge proxies
				detect: [ :p | p oid = self oid ]
				ifFound: [ :p | 
					p closure: nil.
					^ true ].
			aBridge proxies
				detect: [ :p | p jsName = self globalName ]
				ifFound: [ :p | 
					p closure: nil.
					^ true ].
			self error: 'proxy to be removed not found' ].
	proxy := PjProxy
		proxyNamed: self globalName asSymbol
		onBridge: aBridge
		oid: self oid asSymbol.
	^ proxy
]

{ #category : #accessing }
PjProxyInfo >> remove [
	^ remove
]

{ #category : #accessing }
PjProxyInfo >> remove: anObject [
	remove := anObject
]

Class {
	#name : #PjProxyManager,
	#superclass : #Object,
	#classVars : [
		'currentId'
	],
	#pools : [
		'PjNodeGlobals'
	],
	#category : #'PharoJsBridge-Client-WebSocketDelegate'
}

{ #category : #'instance creation' }
PjProxyManager class >> atGlobalVarName: globalId put: anObject [
	global at: globalId put: anObject
]

{ #category : #'default instance' }
PjProxyManager class >> deleteGlobalVarNamed: globalId [
	globalId ifNil: [ ^ self ].
	globalId isEmpty
		ifTrue: [ ^ self ].
	(global instVarNamed: globalId)
		ifNotNil: [ :obj | 
			obj
				ifNotNil: [ "self removeGlobalId: globalId fromObject: obj."
					global removeKey: globalId ] ]
]

{ #category : #'instance creation' }
PjProxyManager class >> ensureObjectRegistered: anObject [
	| oid globalId |
	oid := self ensureOidOnObject: anObject.
	globalId := PjProxyManager nextGlobalVarName.
	self atGlobalVarName: globalId put: anObject.
	^ oid -> globalId
]

{ #category : #'instance creation' }
PjProxyManager class >> ensureOidOnObject: anObject [
	^ (self getOidFrom: anObject)
		ifNil: [ | oid |
			oid := PjProxyManager nextOid.
			self setOid: oid on: anObject.
			oid ]
]

{ #category : #'instance creation' }
PjProxyManager class >> getOidFrom: anObject [
	^anObject instVarNamed: self oidVarName
]

{ #category : #'instance creation' }
PjProxyManager class >> makeBlockClosureProxy: withThis stopPropagation: stop for: webSocketDelegate [
	<PhxTicket: 'T#000322' name: 'Refactoring ParoJs PjBridge'>
	| blockClosure oid |
	oid := PjProxyManager nextOid.
	blockClosure := [ :ev | 
	| target msg|
	stop
		ifTrue: [ ev stopPropagation ].
	target := withThis
		ifFalse: [ nil ]
		ifTrue: [ ev target ifNil: [ ev sourceElement ] ].
	msg := PjMessageCallback newWithId.
	msg receiverProxyInfo: blockClosure proxyResponse.
	msg eventProxyInfo: ev proxyResponse.
	msg eventTargetProxyInfo: target proxyResponse.
	webSocketDelegate tryToSendMessage: msg.
	true ].
	blockClosure instVarNamed: '$PjRefCount' put: 0.
	self setOid: oid on: blockClosure.
	self atGlobalVarName: oid put: blockClosure.
	^ blockClosure proxyResponse
]

{ #category : #'instance creation' }
PjProxyManager class >> nextGlobalVarName [
	^ '$_' , self nextIdNumber asString
]

{ #category : #'instance creation' }
PjProxyManager class >> nextIdNumber [
	currentId := currentId ifNil: [ 1 ] ifNotNil: [ :id | id + 1 ].
	^ currentId
]

{ #category : #'instance creation' }
PjProxyManager class >> nextOid [
	^ '$_' , self nextIdNumber asString
]

{ #category : #'default instance' }
PjProxyManager class >> oidVarName [
	^ '$_oid'
]

{ #category : #'instance creation' }
PjProxyManager class >> setOid: anOid on: anObject [
	anObject instVarNamed: self oidVarName putHidden: anOid
]

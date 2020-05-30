Class {
	#name : #PjMessageInspect,
	#superclass : #PjMessageC2s,
	#instVars : [
		'subjectProxyInfo'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #testing }
PjMessageInspect >> isCallback [
	^ true
]

{ #category : #public }
PjMessageInspect >> processCallbackWithBridge: aBridge [
	<pharoJsSkip>
	(self serverObjectForSubjectWithBridge: aBridge) inspect
]

{ #category : #public }
PjMessageInspect >> serverObjectForSubjectWithBridge: aBridge [
	<pharoJsSkip>
	subjectProxyInfo isLiteral
		ifTrue: [ ^ subjectProxyInfo ].
	subjectProxyInfo isNumber
		ifTrue: [ ^ subjectProxyInfo ].
	^ subjectProxyInfo proxyForBridge: aBridge
]

{ #category : #accessing }
PjMessageInspect >> subjectProxyInfo [
	^ subjectProxyInfo
]

{ #category : #accessing }
PjMessageInspect >> subjectProxyInfo: anObject [
	subjectProxyInfo := anObject
]

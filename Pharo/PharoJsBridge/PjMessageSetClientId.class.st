Class {
	#name : #PjMessageSetClientId,
	#superclass : #PjMessageC2s,
	#instVars : [
		'clientId'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #accessing }
PjMessageSetClientId >> clientId [
	^ clientId
]

{ #category : #accessing }
PjMessageSetClientId >> clientId: anObject [
	clientId := anObject
]

{ #category : #testing }
PjMessageSetClientId >> isCallback [
	^false
]

{ #category : #testing }
PjMessageSetClientId >> needsToBeQueued [
	^false
]

{ #category : #testing }
PjMessageSetClientId >> processWithBridge: aBridge [
	aBridge client clientId: self clientId
]

{ #category : #testing }
PjMessageSetClientId >> shouldEvaluateImmediately [
	^true
]

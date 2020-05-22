Class {
	#name : #PjMessageSetClientId,
	#superclass : #PjMessage,
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
PjMessageSetClientId >> needsToBeQueued [
	^false
]

{ #category : #testing }
PjMessageSetClientId >> processWithBridge: aBridge [
	aBridge client clientId: self clientId
]

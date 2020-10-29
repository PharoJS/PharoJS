Class {
	#name : #PjMessageSetClientId,
	#superclass : #PjMessageC2s,
	#instVars : [
		'clientId'
	],
	#category : #'PharoJsBridge-Messages'
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

{ #category : #printing }
PjMessageSetClientId >> logDescription [
	^ String
		streamContents: [ :ws | 
			ws nextPutAll: self class name.
			ws nextPutAll: ' id: '.
			ws nextPutAll: self id asString.
			ws nextPutAll: ' clientId: '.
			ws nextPutAll: self clientId ]
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

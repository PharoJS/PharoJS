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

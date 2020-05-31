Class {
	#name : #PjMessageErrorResponse,
	#superclass : #PjMessageC2s,
	#instVars : [
		'inResponseToId'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #accessing }
PjMessageErrorResponse >> getValueWithBridge: aBridge [
	PjJavascriptError signal: self contents
]

{ #category : #accessing }
PjMessageErrorResponse >> inResponseToId [
	^ inResponseToId
]

{ #category : #accessing }
PjMessageErrorResponse >> inResponseToId: anObject [
	inResponseToId := anObject
]

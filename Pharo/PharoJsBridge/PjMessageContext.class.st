Class {
	#name : #PjMessageContext,
	#superclass : #Object,
	#instVars : [
		'websocketDelegate'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #accessing }
PjMessageContext >> websocketDelegate [
	^ websocketDelegate
]

{ #category : #accessing }
PjMessageContext >> websocketDelegate: anObject [
	websocketDelegate := anObject
]

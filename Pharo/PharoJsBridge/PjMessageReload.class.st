Class {
	#name : #PjMessageReload,
	#superclass : #PjMessageS2c,
	#category : #'PharoJsBridge-Messages'
}

{ #category : #public }
PjMessageReload >> evaluateInContext: aMessageContext [
	aMessageContext websocketDelegate class reload
]

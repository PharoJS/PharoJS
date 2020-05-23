Class {
	#name : #PjMessageReload,
	#superclass : #PjMessageS2c,
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #public }
PjMessageReload >> evaluateInContext: aMessageContext [
	aMessageContext websocketDelegate class reload
]

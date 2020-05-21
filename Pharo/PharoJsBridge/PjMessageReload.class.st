Class {
	#name : #PjMessageReload,
	#superclass : #PjMessage,
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #public }
PjMessageReload >> evaluateInContext: aMessageContext [
	aMessageContext websocketDelegate class reload
]

Class {
	#name : #PjMessageTerminate,
	#superclass : #PjMessageS2c,
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #public }
PjMessageTerminate >> evaluateInContext: aMessageContext [
	aMessageContext websocketDelegate class terminate
]

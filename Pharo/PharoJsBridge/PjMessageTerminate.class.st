Class {
	#name : #PjMessageTerminate,
	#superclass : #PjMessage,
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #public }
PjMessageTerminate >> evaluateInContext: aMessageContext [
	aMessageContext websocketDelegate class terminate
]

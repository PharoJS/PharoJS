Class {
	#name : #PjMessageTerminate,
	#superclass : #PjMessageS2c,
	#category : #'PharoJsBridge-Messages'
}

{ #category : #public }
PjMessageTerminate >> evaluateInContext: aMessageContext [
	aMessageContext websocketDelegate class terminate
]

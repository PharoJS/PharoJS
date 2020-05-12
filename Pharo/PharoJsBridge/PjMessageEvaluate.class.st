Class {
	#name : #PjMessageEvaluate,
	#superclass : #PjMessage,
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #public }
PjMessageEvaluate >> evaluateInContext: aMessageContext [
	| wsd |
	wsd := aMessageContext websocketDelegate.
	self
		timeout: [ | resultString responseMsg |
			resultString := wsd eval: contents.
			responseMsg := PjMessageResponse newWithContents: resultString.
			console log: responseMsg logDescription .
			responseMsg inResponseToId: self id.
			wsd tryToSendMessage: responseMsg ]
		for: 0
]

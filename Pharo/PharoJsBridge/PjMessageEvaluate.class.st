Class {
	#name : #PjMessageEvaluate,
	#superclass : #PjMessageS2c,
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #public }
PjMessageEvaluate >> evaluateInContext: aMessageContext [
	| wsd |
	wsd := aMessageContext websocketDelegate.
	self
		timeout: [ | resultString responseMsg |
			resultString := wsd evalSafe: contents.
			responseMsg := PjMessageResponse newWithContents: resultString.
			responseMsg inResponseToId: self id.
			"console log: responseMsg logDescription ."
			wsd tryToSendMessage: responseMsg ]
		for: 0
]

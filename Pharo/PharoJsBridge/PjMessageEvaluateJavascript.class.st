Class {
	#name : #PjMessageEvaluateJavascript,
	#superclass : #PjMessageS2c,
	#category : #'PharoJsBridge-Messages'
}

{ #category : #public }
PjMessageEvaluateJavascript >> evaluateInContext: aMessageContext [
	self
		timeout: [ self evaluateInContextPrivate: aMessageContext ]
		for: 0
]

{ #category : #public }
PjMessageEvaluateJavascript >> evaluateInContextPrivate: aMessageContext [
	| responseMsg |
	responseMsg := [ PjMessageEvaluationResponse
		newWithContents: (self evaluateJsString: contents) ]
		on: Error
		do:
			[ :ex | (PjMessageErrorResponse newWithContents: ex message) ].
	responseMsg inResponseToId: self id.
	aMessageContext websocketDelegate tryToSendMessage: responseMsg
]

{ #category : #public }
PjMessageEvaluateJavascript >> evaluateJsString: aString [
	| resultObject resultString |
	resultObject := (global eval: aString)
		ifNotNil: [ :result | result proxyResponse ].
	resultObject class == PjProxyInfo
		ifTrue: [ ^ resultObject ].
	resultString := JSON stringify: resultObject.
	resultObject
		ifNotNil: [ resultString = 'null'
				ifTrue: [ resultString := resultObject toString ] ].
	resultString ifNil: [ resultString := 'null' ].
	^ resultString
]

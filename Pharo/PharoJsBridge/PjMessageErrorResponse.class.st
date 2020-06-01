Class {
	#name : #PjMessageErrorResponse,
	#superclass : #PjMessageC2sInResponseTo,
	#category : #'PharoJsBridge-Messages'
}

{ #category : #accessing }
PjMessageErrorResponse >> getValueWithBridge: aBridge [
	PjJavascriptError signal: self contents
]

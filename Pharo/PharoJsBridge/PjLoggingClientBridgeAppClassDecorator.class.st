Class {
	#name : #PjLoggingClientBridgeAppClassDecorator,
	#superclass : #PjBridgeAppClassDecorator,
	#category : #'PharoJsBridge-Client-CodeGenerator'
}

{ #category : #accessing }
PjLoggingClientBridgeAppClassDecorator class >> websocketDelegateClass [
	^ PjLoggingEvaluatorWebsocketDelegate
]

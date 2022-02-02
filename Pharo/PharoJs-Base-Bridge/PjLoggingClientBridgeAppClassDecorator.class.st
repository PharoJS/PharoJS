Class {
	#name : #PjLoggingClientBridgeAppClassDecorator,
	#superclass : #PjBridgeAppClassDecorator,
	#category : #'PharoJs-Base-Bridge-Client-CodeGenerator'
}

{ #category : #accessing }
PjLoggingClientBridgeAppClassDecorator class >> websocketDelegateClass [

	^ PjLoggingEvaluatorWebsocketDelegate
]

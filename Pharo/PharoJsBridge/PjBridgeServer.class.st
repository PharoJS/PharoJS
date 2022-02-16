Class {
	#name : #PjBridgeServer,
	#superclass : #Object,
	#instVars : [
		'timing',
		'html',
		'javascript',
		'css',
		'favicon',
		'fingerPrint',
		'znServer',
		'webSocket',
		'bridge'
	],
	#classVars : [
		'CurrentUsablePortNumber'
	],
	#category : #'PharoJsBridge-Kernel'
}

{ #category : #accessing }
PjBridgeServer >> value: aWebSocket [
	[ self webSocket: aWebSocket.
	aWebSocket
		runWith:
			[ :aMessage | self safelyHandleMessage: aMessage forSocket: aWebSocket ] ]
		on: Error
		do: [ "self webSocket: nil" ]	
]

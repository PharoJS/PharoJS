Class {
	#name : #PjBridgeStartStopServerTest,
	#superclass : #TestCase,
	#category : #'PharoJsBridgeTest-Tests'
}

{ #category : #accessing }
PjBridgeStartStopServerTest class >> defaultTimeLimit [
	^60 seconds
]

{ #category : #testing }
PjBridgeStartStopServerTest >> testBridgeStartStop [
	10
		timesRepeat: [ | b |
			b := PjBridge new.
			[ b startServer.
			self assert: b isServerStartedExtraCheck ]
				ensure: [ b stopServer ] ]
]

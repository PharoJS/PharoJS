Class {
	#name : #PjDebugBridgeTestResource,
	#superclass : #PjBridgeTestResource,
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #running }
PjDebugBridgeTestResource >> setUpClient [
	self bridge withClientLogging
]

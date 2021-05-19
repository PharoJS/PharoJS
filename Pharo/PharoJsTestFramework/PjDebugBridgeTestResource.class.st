Class {
	#name : #PjDebugBridgeTestResource,
	#superclass : #PjBridgeTestResource,
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #running }
PjDebugBridgeTestResource >> ensureFreshClient [
	self bridge startJsInterpreter
]

{ #category : #running }
PjDebugBridgeTestResource >> resetClient [
	self bridge resetClient
]

{ #category : #running }
PjDebugBridgeTestResource >> setUpClient [
	super setUpClient.
	self bridge enableClientLogging
]

Class {
	#name : #PjDebugBridgeTestResource,
	#superclass : #PjBridgeTestResource,
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #running }
PjDebugBridgeTestResource >> ensureFreshClient [

	self startJsInterpreter
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

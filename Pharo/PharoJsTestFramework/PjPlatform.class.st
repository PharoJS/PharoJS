"
I and my subclasses are used to launch instances of a Javascript platform (browser or server) for test purposes
"
Class {
	#name : #PjPlatform,
	#superclass : #PjBridgeTestResource,
	#classInstVars : [
		'currentAppClass'
	],
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #accessing }
PjPlatform class >> currentAppClass [
	^ currentAppClass
]

{ #category : #accessing }
PjPlatform class >> currentAppClass: anObject [
	currentAppClass := anObject
]

{ #category : #accessing }
PjPlatform >> appClass [
	^ self class currentAppClass  
]

{ #category : #accessing }
PjPlatform >> appFolder [
	^ self appClass appFolder
]

{ #category : #running }
PjPlatform >> bridgeIp [
	^'127.0.0.1'.
]

{ #category : #running }
PjPlatform >> clientClass [
	^ PjPlatformBoundFileBasedBrowserBridgeClient
]

{ #category : #running }
PjPlatform >> ensureAppFolderValid [
	[self appFolder] 
		on: Error 
		do: [self fail: 'Invalid app folder! Please restart test']
]

{ #category : #testing }
PjPlatform >> isAvailable [
	^self bridge isConnected.
]

{ #category : #running }
PjPlatform >> maxWaitClientReadyDuration [
	^10 seconds
]

{ #category : #running }
PjPlatform >> pathString: aFileReference [ 
	aFileReference exists ifFalse: [ 
		^self fail: 'Could not launch app ', self appClass name, ' - no file ', aFileReference pathString].
	^ aFileReference pathString
]

{ #category : #running }
PjPlatform >> resetApp [
	self bridge resetClient.
]

{ #category : #running }
PjPlatform >> setUp [
	super setUp.
	self waitUntilClientReady
]

{ #category : #running }
PjPlatform >> setUpBridge [
	| client |
	self ensureAppFolderValid.
	client := self clientClass newFor: self.
	self bridge: (PjBridge bridgeForApp: self appClass client: client)
]

{ #category : #running }
PjPlatform >> waitUntilClientReady [
	self 
		waitWhile: [self isUnavailable]
		timeOut: self maxWaitClientReadyDuration
		ifTimeOutDo: [
			|retry|
			retry := self confirm: 'Client unavailable yet. Continue waiting?'.
			retry ifFalse: [ ^self fail].
			self waitUntilClientReady 		
		]

]

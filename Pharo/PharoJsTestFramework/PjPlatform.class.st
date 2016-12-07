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
PjPlatform >> maxWaitDuration [
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
	self waitUntilClientReady "useless?"
]

{ #category : #running }
PjPlatform >> setUpBridge [
	| client |
	self ensureAppFolderValid.
	super setUpBridge.
	client := PjBrowserSpecificFileBasedBridgeClient newFor: self.
	self bridge client: client.
	self bridge appClass: self appClass.


]

{ #category : #running }
PjPlatform >> waitUntilClientReady [
	self 
		waitWhile: [self isUnavailable]
		timeOut: self maxWaitDuration
		ifTimeOutDo: [
			|retry|
			retry := self confirm: 'Client unavailable yet. Continue waiting?'.
			retry ifFalse: [ ^self fail].
			self waitUntilClientReady 		
		]

]

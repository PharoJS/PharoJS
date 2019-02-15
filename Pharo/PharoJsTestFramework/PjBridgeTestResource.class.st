Class {
	#name : #PjBridgeTestResource,
	#superclass : #TestResource,
	#instVars : [
		'bridge',
		'appClass'
	],
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #'instance creation' }
PjBridgeTestResource class >> appClass: aClass [
	^self new
		appClass: aClass;
		yourself.

]

{ #category : #running }
PjBridgeTestResource class >> availableFor: aTestAsserter [
	super availableFor: aTestAsserter.
	self ensureAppClassFor: aTestAsserter.
	self ensureFreshClient
]

{ #category : #'instance creation' }
PjBridgeTestResource class >> currentAppClass: aClass [
	current := self appClass: aClass
]

{ #category : #running }
PjBridgeTestResource class >> ensureAppClassFor: aTestAsserter [
	self current appClass == aTestAsserter appClassToExport ifTrue: [ ^self ].
	self currentAppClass: aTestAsserter appClassToExport
]

{ #category : #running }
PjBridgeTestResource class >> ensureFreshClient [
	self current ensureFreshClient
]

{ #category : #accessing }
PjBridgeTestResource >> appClass [
	^appClass 
]

{ #category : #accessing }
PjBridgeTestResource >> appClass: aClass [
	appClass := aClass.
	self bridge: appClass bridge. 
	PjBridge bridge: self bridge.
	self bridge shouldStartJsInterpreter: false.
	self setUpClient.
	self bridge	startWithoutWaitingForClient.

]

{ #category : #accessing }
PjBridgeTestResource >> bridge [
	^ bridge
]

{ #category : #accessing }
PjBridgeTestResource >> bridge: aBridge [
	bridge := aBridge.

]

{ #category : #running }
PjBridgeTestResource >> ensureFreshClient [
	self bridge ensureServerProcessAlive.
	self bridge isConnected ifTrue: [^self bridge resetClient].
	self bridge startJsInterpreter
]

{ #category : #'initialize-release' }
PjBridgeTestResource >> initialize [
	super initialize.
	self description: 'I manage a bridge dedicated to testing a PharoJS app'.
	self name: 'PharoJS Bridge TestResource'.
]

{ #category : #running }
PjBridgeTestResource >> setUpClient [
	^self "Use default client"
]

{ #category : #running }
PjBridgeTestResource >> tearDown [
	super tearDown.
	self bridge ifNotNil: [
		self bridge stop.
		PjBridge bridge: nil
	].

]

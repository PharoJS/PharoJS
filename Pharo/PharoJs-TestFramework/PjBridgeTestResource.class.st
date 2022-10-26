Class {
	#name : #PjBridgeTestResource,
	#superclass : #TestResource,
	#instVars : [
		'bridge',
		'appClass',
		'execEnv'
	],
	#classVars : [
		'OpenWebBrowserInBackground'
	],
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #running }
PjBridgeTestResource class >> availableFor: aTestAsserter [
	super availableFor: aTestAsserter.
	self ensureAppClassFor: aTestAsserter.
	self ensureFreshClient
]

{ #category : #running }
PjBridgeTestResource class >> ensureAppClassFor: aTestAsserter [
	self current appClass == aTestAsserter appClassToExport ifTrue: [ ^self ].
	self setCurrentWithNewForAppClass: aTestAsserter appClassToExport
]

{ #category : #running }
PjBridgeTestResource class >> ensureFreshClient [
	self current ensureFreshClient
]

{ #category : #accessing }
PjBridgeTestResource class >> isClientBrowserOpenedInBackground [
	^OpenWebBrowserInBackground ifNil: [ false ]
]

{ #category : #accessing }
PjBridgeTestResource class >> isClientBrowserOpenedInBackground: aBoolean [
	^OpenWebBrowserInBackground := aBoolean 
]

{ #category : #'instance creation' }
PjBridgeTestResource class >> newWithAppClass: aClass [
	^ self new
		initializeWithAppClass: aClass;
		yourself
]

{ #category : #'instance creation' }
PjBridgeTestResource class >> setCurrentWithNewForAppClass: aClass [
	current := self newWithAppClass: aClass
]

{ #category : #accessing }
PjBridgeTestResource class >> setWebBrowserOpenedInBackground [

	<script>
	self isClientBrowserOpenedInBackground: true
]

{ #category : #accessing }
PjBridgeTestResource class >> setWebBrowserOpenedInForeground [

	<script>
	self isClientBrowserOpenedInBackground: false
]

{ #category : #accessing }
PjBridgeTestResource >> appClass [
	^appClass
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
	self bridge isConnected ifTrue: [^self resetClient].
	self bridge startJsInterpreter
]

{ #category : #initialization }
PjBridgeTestResource >> initialize [
	super initialize.
	self description: 'I manage a bridge dedicated to testing a PharoJS app'.
	self name: 'PharoJS Bridge TestResource'.
]

{ #category : #accessing }
PjBridgeTestResource >> initializeWithAppClass: aClass [

	appClass := aClass.
	appClass resetAppFolder.
	self bridge: appClass bridge.
	PjBridge soleBridge: self bridge.
	self bridge shouldStartJsInterpreter: false.
	self setUpClient.
	DefaultExecutionEnvironment beActiveDuring: [ 
		self bridge startWithoutWaitingForClient ]
]

{ #category : #running }
PjBridgeTestResource >> isClientBrowserOpenedInBackground [
	^self class isClientBrowserOpenedInBackground
]

{ #category : #running }
PjBridgeTestResource >> resetClient [
	self bridge resetClient
]

{ #category : #running }
PjBridgeTestResource >> setUp [
]

{ #category : #running }
PjBridgeTestResource >> setUpClient [
	^self bridge client openBrowserInBackground: self isClientBrowserOpenedInBackground
]

{ #category : #running }
PjBridgeTestResource >> tearDown [
	super tearDown.
	self bridge
		ifNotNil: [ self bridge tearDown.
			PjBridge soleBridge: nil ].
	Smalltalk garbageCollect
]

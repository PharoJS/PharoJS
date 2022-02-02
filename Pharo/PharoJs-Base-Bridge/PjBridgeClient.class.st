"
I represent a bridge client i.e. javascript interpreter and code that talks to a bridge.
"
Class {
	#name : #PjBridgeClient,
	#superclass : #Object,
	#instVars : [
		'bridge',
		'codeGenerator',
		'exporter',
		'appClass',
		'clientId'
	],
	#category : #'PharoJs-Base-Bridge-Kernel'
}

{ #category : #'instance creation' }
PjBridgeClient class >> newWithAppClass: pjAppClass [

	^ self new
		  initializeWithAppClass: pjAppClass;
		  yourself
]

{ #category : #accessing }
PjBridgeClient >> appClass [

	^ appClass ifNil: [ self defaultAppClass ]
]

{ #category : #accessing }
PjBridgeClient >> bridge [

	^ bridge
]

{ #category : #accessing }
PjBridgeClient >> clientId [

	^ clientId
]

{ #category : #accessing }
PjBridgeClient >> clientId: anObject [

	clientId := anObject
]

{ #category : #accessing }
PjBridgeClient >> codeGenerator [

	^ codeGenerator
]

{ #category : #accessing }
PjBridgeClient >> codeGenerator: aCodeGenerator [

	| decoratedAppClass |
	codeGenerator := aCodeGenerator.
	decoratedAppClass := codeGenerator decorateAppClass: appClass.
	exporter initializeWithAppClass: decoratedAppClass
]

{ #category : #accessing }
PjBridgeClient >> codeGeneratorClass [

	self codeGenerator ifNil: [ ^ PjClientCodeGenerator ].
	^ self codeGenerator species
	"Allows keeping the behavior upon reseting the client in the bridge. See PjBridge>>#resetClient"
]

{ #category : #'accessing - defaults' }
PjBridgeClient >> defaultAppClass [

	self subclassResponsibility
]

{ #category : #accessing }
PjBridgeClient >> exporter [

	^ exporter
]

{ #category : #accessing }
PjBridgeClient >> exporterClass [

	self subclassResponsibility
]

{ #category : #accessing }
PjBridgeClient >> initializeWithAppClass: aPharoJsAppClass [

	appClass := aPharoJsAppClass.
	exporter := self exporterClass new.
	self codeGenerator: self codeGeneratorClass new
]

{ #category : #accessing }
PjBridgeClient >> initializeWithBridge: aBridge [

	bridge := aBridge.
	self codeGenerator bridge: self bridge
]

{ #category : #accessing }
PjBridgeClient >> jsGlobalNames [

	^ (self appClass allSharedPoolsRecursive select:
		   #isJavascriptGlobalsPool) flatCollectAsSet: #classVarNames
]

{ #category : #accessing }
PjBridgeClient >> openBrowserInBackground: aBoolean [
	"Useful only for Browser apps"

	^ self
]

{ #category : #accessing }
PjBridgeClient >> pharoJsSelectorPrefix [

	^ exporter transpiler pharoJsSelectorPrefix
]

{ #category : #initialization }
PjBridgeClient >> reset [

	self initializeWithAppClass: self appClass.
	self initializeWithBridge:  self bridge.
	self clientId: nil.
	"Ensure transpiler is reset correctly.
	Transpiler is driven by exporter"
	String streamContents: [ :aStream | self exporter writeJsCodeOn: aStream ]
]

{ #category : #accessing }
PjBridgeClient >> server [

	^ self bridge server
]

{ #category : #accessing }
PjBridgeClient >> shouldStartJsInterpreter [

	^ self bridge shouldStartJsInterpreter
]

{ #category : #actions }
PjBridgeClient >> start [

	self shouldStartJsInterpreter ifTrue: [ self startJsInterpreter ]
]

{ #category : #actions }
PjBridgeClient >> startJsInterpreter [
	"start javascript interpreter"

	self subclassResponsibility
]

{ #category : #actions }
PjBridgeClient >> startTimeout [

	^ 2 seconds
]

{ #category : #actions }
PjBridgeClient >> stop [
	"stop javascript interpreter"

	self server ifNil: [ ^ self ].
	self server isWebSocketConnected ifFalse: [ ^ self ].
	self bridge websocketDelegateClassName ifNil: [ ^ self ].
	[ self bridge sendMessage: PjMessageTerminate new ]
		on: ConnectionTimedOut
		do: [ " nothing: the socket's gone away " ]
]

{ #category : #accessing }
PjBridgeClient >> title [

	^ self appClass title
]

{ #category : #accessing }
PjBridgeClient >> websocketDelegateClass [

	^ self codeGenerator websocketDelegateClass
]

{ #category : #accessing }
PjBridgeClient >> websocketDelegateClassName [

	^ self codeGenerator websocketDelegateClassName
]

{ #category : #accessing }
PjBridgeClient >> withClientLogging [

	self codeGenerator: self codeGenerator withClientLogging
]

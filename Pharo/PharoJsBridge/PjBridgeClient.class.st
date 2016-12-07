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
		'appClass'
	],
	#category : #'PharoJsBridge-Kernel'
}

{ #category : #accessing }
PjBridgeClient >> appClass [
	^ appClass
]

{ #category : #accessing }
PjBridgeClient >> appClass: aPharoJsAppClass [
	self exporter: self exporter codeGenerator: self codeGenerator appClass: aPharoJsAppClass
]

{ #category : #accessing }
PjBridgeClient >> bridge [
	^ bridge
]

{ #category : #accessing }
PjBridgeClient >> bridge: aBridge [
	bridge := aBridge.

]

{ #category : #'initialization-release' }
PjBridgeClient >> clientGeneratorClass [
	^PjClientCodeGenerator
]

{ #category : #accessing }
PjBridgeClient >> codeGenerator [
	^ codeGenerator
]

{ #category : #accessing }
PjBridgeClient >> codeGenerator: aGenerator [
	self exporter: self exporter codeGenerator: aGenerator appClass: self appClass
]

{ #category : #'initialization-release' }
PjBridgeClient >> defaultAppClass [
	self subclassResponsibility
]

{ #category : #accessing }
PjBridgeClient >> exporter [
	^ exporter
]

{ #category : #accessing }
PjBridgeClient >> exporter: anExporter codeGenerator: aGenerator appClass: aPharoJsAppClass [
	| decoratedAppClass |
	appClass := aPharoJsAppClass.
	codeGenerator := aGenerator.
	exporter := anExporter.
	decoratedAppClass := codeGenerator decorateAppClass: appClass forBridge: self bridge.
	exporter appClass: decoratedAppClass.

]

{ #category : #'initialization-release' }
PjBridgeClient >> exporterClass [
	self subclassResponsibility
]

{ #category : #'initialization-release' }
PjBridgeClient >> initialize [
	super initialize.
	self 
		exporter: self exporterClass new 
		codeGenerator: self clientGeneratorClass new
		appClass: self defaultAppClass.
]

{ #category : #accessing }
PjBridgeClient >> jsGlobalNames [
	^ (appClass allSharedPoolsRecursive select: #isJavascriptGlobalsPool)
			flatCollectAsSet: #classVarNames
]

{ #category : #accessing }
PjBridgeClient >> server [
	^self bridge server
]

{ #category : #activity }
PjBridgeClient >> start [
	"start javascript interpreter"
	self subclassResponsibility
]

{ #category : #activity }
PjBridgeClient >> stop [
	"stop javascript interpreter"
	self bridge websocketDelegateClassName ifNil: [ ^self ].
	self bridge sendMessage: self bridge websocketDelegateClassName, '._terminate()'.

]

{ #category : #accessing }
PjBridgeClient >> websocketDelegateClassName [
	^self codeGenerator websocketDelegateClassName
]

{ #category : #accessing }
PjBridgeClient >> withClientLogging [
	^ self codeGenerator: self codeGenerator withClientLogging
]

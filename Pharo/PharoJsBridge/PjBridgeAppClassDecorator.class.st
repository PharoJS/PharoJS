Class {
	#name : #PjBridgeAppClassDecorator,
	#superclass : #Object,
	#instVars : [
		'rawAppClass',
		'bridge'
	],
	#category : #'PharoJsBridge-Client-CodeGenerator'
}

{ #category : #'instance creation' }
PjBridgeAppClassDecorator class >> rawAppClass: anAppClass [ 
	^ self new
		rawAppClass: anAppClass;
		yourself
]

{ #category : #accessing }
PjBridgeAppClassDecorator class >> websocketDelegateClass [
	^PjEvaluatorWebsocketDelegate 
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> appClasses [
	^self rawAppClass appClasses , self classesForBridgeClient
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> appLaunchBlock [
	| appClass webSocketDelegateClass url |
	appClass := self rawAppClass.
	webSocketDelegateClass := self websocketDelegateClass.
	url := self bridgeWebSocketUrl.
	^ [ appClass start.
	webSocketDelegateClass connectDefaultToUrl: url ] asClosedBlock
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> appPackages [
	^self rawAppClass appPackages.
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> bridge [
	^ bridge
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> bridge: anObject [
	bridge := anObject
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> bridgeUrl [
	^ self bridge serverUrl
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> bridgeWebSocketUrl [
	| rawUrl |
	rawUrl := self bridgeUrl / self webSocketUrlTag.
	^ 'ws:' , (rawUrl asString copyAfter: $:)
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> classesForBridgeClient [
	^ self websocketDelegateClass allSuperclasses
]

{ #category : #polyfill }
PjBridgeAppClassDecorator >> globalsPools [
	^ self rawAppClass globalsPools
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> headerLine [
	^self rawAppClass headerLine
]

{ #category : #polyfill }
PjBridgeAppClassDecorator >> polyfill: aPolyfillClass onStream: aStream unlessIn: aSet [
	self rawAppClass
		polyfill: aPolyfillClass
		onStream: aStream
		unlessIn: aSet
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> rawAppClass [
	^ rawAppClass
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> rawAppClass: anObject [
	rawAppClass := anObject
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> setupCode [
	^self rawAppClass setupCode.
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> webSocketUrlTag [
	^ self bridge webSocketUrlTag
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> websocketDelegateClass [
	^ self class websocketDelegateClass
]

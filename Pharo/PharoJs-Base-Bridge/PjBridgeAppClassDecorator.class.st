Class {
	#name : #PjBridgeAppClassDecorator,
	#superclass : #Object,
	#instVars : [
		'rawAppClass',
		'bridge'
	],
	#category : #'PharoJs-Base-Bridge-Client-CodeGenerator'
}

{ #category : #'instance creation' }
PjBridgeAppClassDecorator class >> rawAppClass: anAppClass [

	^ self new
		  rawAppClass: anAppClass;
		  yourself
]

{ #category : #accessing }
PjBridgeAppClassDecorator class >> websocketDelegateClass [

	^ PjEvaluatorWebsocketDelegate
]

{ #category : #exporting }
PjBridgeAppClassDecorator >> afterExportApp [

	rawAppClass afterExportApp
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> appClasses [

	^ self rawAppClass appClasses , self classesForBridgeClient
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> appLaunchBlock [

	| appClass webSocketDelegateClass url |
	appClass := self rawAppClass.
	webSocketDelegateClass := self websocketDelegateClass.
	url := self bridgeWebSocketUrl.
	^ [ 
	  appClass start.
	  webSocketDelegateClass connectDefaultToUrl: url ] asClosedBlock
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> appPackages [

	^ self rawAppClass appPackages
]

{ #category : #exporting }
PjBridgeAppClassDecorator >> beforeExportApp [ 
	rawAppClass beforeExportApp
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

	^ self rawAppClass headerLine
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> pharoJsSelectorPrefix [
	<pharoJsSkip>
	
	^ rawAppClass pharoJsSelectorPrefix
]

{ #category : #polyfill }
PjBridgeAppClassDecorator >> polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet [

	self rawAppClass
		polyfill: aPolyfillClass
		withTranspiler: aTranspiler
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

	^ self rawAppClass setupCode
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> webSocketUrlTag [

	^ self bridge webSocketUrlTag
]

{ #category : #accessing }
PjBridgeAppClassDecorator >> websocketDelegateClass [

	^ self class websocketDelegateClass
]

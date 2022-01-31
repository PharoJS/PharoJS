Extension { #name : #PjApplication }

{ #category : #'*PharoJsBridge-App' }
PjApplication class >> bridge [
	<pharoJsSkip>
	^ PjBridge bridgeForAppClass: self
]

{ #category : #'*PharoJsBridge-App' }
PjApplication class >> bridgeAddress [
	<pharoJsSkip>
	^ '127.0.0.1'
]

{ #category : #'*PharoJsBridge-App' }
PjApplication class >> bridgeClass [
	<pharoJsSkip>
	^ PjBridge
]

{ #category : #'*PharoJsBridge-App' }
PjApplication class >> bridgeClientClass [
	<pharoJsSkip>
	self subclassResponsibility
]

{ #category : #'*PharoJsBridge-App' }
PjApplication class >> bridgeForDebug [
	<pharoJsSkip>
	^ self bridge enableClientLogging
]

{ #category : #'*PharoJsBridge-App' }
PjApplication class >> newBridgeClient [
	<pharoJsSkip>
	^self bridgeClientClass newWithAppClass: self
]

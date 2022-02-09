Extension { #name : #PjApplication }

{ #category : #'*PharoJs-Base-Bridge-App' }
PjApplication class >> bridge [
	<pharoJsSkip>
	^ PjBridge bridgeForAppClass: self
]

{ #category : #'*PharoJs-Base-Bridge-App' }
PjApplication class >> bridgeAddress [
	<pharoJsSkip>
	^ '127.0.0.1'
]

{ #category : #'*PharoJs-Base-Bridge-App' }
PjApplication class >> bridgeClass [
	<pharoJsSkip>
	^ PjBridge
]

{ #category : #'*PharoJs-Base-Bridge-App' }
PjApplication class >> bridgeClientClass [
	<pharoJsSkip>
	self subclassResponsibility
]

{ #category : #'*PharoJs-Base-Bridge-App' }
PjApplication class >> bridgeForDebug [
	<pharoJsSkip>
	^ self bridge enableClientLogging
]

{ #category : #'*PharoJs-Base-Bridge-App' }
PjApplication class >> newBridgeClient [
	<pharoJsSkip>
	^self bridgeClientClass newWithAppClass: self
]

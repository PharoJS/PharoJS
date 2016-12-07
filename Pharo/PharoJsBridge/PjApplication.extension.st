Extension { #name : #PjApplication }

{ #category : #'*PharoJsBridge-App' }
PjApplication classSide >> bridge [
	<pharoJsSkip>
	^ PjBridge bridgeForApp: self

]

{ #category : #'*PharoJsBridge-App' }
PjApplication classSide >> bridgeAddress [
	<pharoJsSkip>
	^ '127.0.0.1'
]

{ #category : #'*PharoJsBridge-App' }
PjApplication classSide >> bridgeClass [
	<pharoJsSkip>
	^ PjBridge
]

{ #category : #'*PharoJsBridge-App' }
PjApplication classSide >> bridgeClientClass [
	<pharoJsSkip>
	self subclassResponsibility
]

{ #category : #'*PharoJsBridge-App' }
PjApplication classSide >> bridgeForDebug [
	<pharoJsSkip>
	^ self bridge withClientLogging

]

{ #category : #'*PharoJsBridge-App' }
PjApplication classSide >> generateHtmlUsing: ignored [
	<pharoJsSkip>
	^ false
]

{ #category : #'*PharoJsBridge-App' }
PjApplication classSide >> ifInvalidFile: file do: aBlock [
	<pharoJsSkip>
	(file isNil or: [(FileStream fileNamed: file) isNil]) ifTrue: aBlock
]

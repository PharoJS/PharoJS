Extension { #name : #PjBridge }

{ #category : #'*PharoJsTools-Playground' }
PjBridge >> pharoPlayground [
	runOnPharo := true.
	PjPlayground openFor: self.
	^ self server
]

{ #category : #'*PharoJsTools-Playground' }
PjBridge >> playground [
	PjPlayground openFor: self.
	^ self server
]

{ #category : #'*PharoJsTools-Playground' }
PjBridge >> playgroundInitialContent [
	^ self client playgroundInitialContent
]

{ #category : #'*PharoJsTools-Playground' }
PjBridge >> playgroundWithoutLaunch [
	self shouldStartJsInterpreter: false.
	^ self playground
]

{ #category : #'*PharoJsTools-Playground' }
PjBridge >> playgroundWithoutLaunchOnUrl: aString [
	self serverUrl: aString.
	self shouldStartJsInterpreter: false.
	^ self playground
]

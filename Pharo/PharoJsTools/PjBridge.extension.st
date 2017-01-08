Extension { #name : #PjBridge }

{ #category : #'*PharoJsTools-Playground' }
PjBridge >> playground [
	PjPlayground openFor: self.
	^ self server
]

{ #category : #'*PharoJsTools-Playground' }
PjBridge >> playgroundWithoutLaunch [
	self launchJavascriptInterpreter: false.
	^ self playground
]

{ #category : #'*PharoJsTools-Playground' }
PjBridge >> playgroundWithoutLaunchOnUrl: aString [
	self serverUrl: aString.
	self launchJavascriptInterpreter: false.
	^ self playground
]

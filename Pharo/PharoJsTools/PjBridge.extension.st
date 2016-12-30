Extension { #name : #PjBridge }

{ #category : #'*PharoJsTools-Playground' }
PjBridge >> playground [
	PjPlayground openFor: self
]

{ #category : #'*PharoJsTools-Playground' }
PjBridge >> playgroundWithoutLaunch [
	self launchJavascriptInterpreter: false.
	PjPlayground openFor: self
]

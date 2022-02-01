Extension { #name : #PjBridge }

{ #category : #'*PharoJs-Tools-Playground' }
PjBridge >> pharoPlayground [
	runOnPharo := true.
	PjPlayground openFor: self.
	^ self server
]

{ #category : #'*PharoJs-Tools-Playground' }
PjBridge >> playground [
	PjPlayground openFor: self.
	^ self server
]

{ #category : #'*PharoJs-Tools-Playground' }
PjBridge >> playgroundInitialContent [
	^ self client playgroundInitialContent
]

{ #category : #'*PharoJs-Tools-Playground' }
PjBridge >> playgroundWithoutLaunch [
	self shouldStartJsInterpreter: false.
	^ self playground
]

{ #category : #'*PharoJs-Tools-Playground' }
PjBridge >> playgroundWithoutLaunchOnUrl: aString [
	self serverUrl: aString.
	self shouldStartJsInterpreter: false.
	^ self playground
]

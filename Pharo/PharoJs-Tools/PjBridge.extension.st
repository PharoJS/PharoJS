Extension { #name : #PjBridge }

{ #category : #'*PharoJs-Tools' }
PjBridge >> pharoPlayground [

	runOnPharo := true.
	PjPlayground openFor: self.
	^ self server
]

{ #category : #'*PharoJs-Tools' }
PjBridge >> playground [

	^ PjPlayground openFor: self

]

{ #category : #'*PharoJs-Tools' }
PjBridge >> playgroundInitialContent [

	^ self client playgroundInitialContent
]

{ #category : #'*PharoJs-Tools' }
PjBridge >> playgroundWithoutLaunch [

	self shouldStartJsInterpreter: false.
	^ self playground
]

{ #category : #'*PharoJs-Tools' }
PjBridge >> playgroundWithoutLaunchOnUrl: aString [

	self serverUrl: aString.
	self shouldStartJsInterpreter: false.
	^ self playground
]

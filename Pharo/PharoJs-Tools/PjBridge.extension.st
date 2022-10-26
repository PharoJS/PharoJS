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

{ #category : #'*PharoJs-Tools' }
PjBridge >> writePlaygroundContentsOn: str [

	str
		<< $";
		<<
			'Connection established with Javascript via PharoJS bridge listening on port ';
		print: self port;
		<< $.;
		<< $";
		cr;
		cr.
	self client writePlaygroundContentsOn: str
]

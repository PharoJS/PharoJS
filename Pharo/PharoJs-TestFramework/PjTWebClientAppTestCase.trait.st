Trait {
	#name : #PjTWebClientAppTestCase,
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #running }
PjTWebClientAppTestCase >> debugBridgeResourceClass [

	^ self
	defaultBridgeResourceClass

]

{ #category : #accessing }
PjTWebClientAppTestCase >> defaultBridgeResourceClass [

	^ PjWebClientAppBridgeTestResource
]

{ #category : #initialization }
PjTWebClientAppTestCase >> serverAppClass [

	^ self appClass serverAppClass
]

{ #category : #initialization }
PjTWebClientAppTestCase >> urlPathString [
	self explicitRequirement 
]

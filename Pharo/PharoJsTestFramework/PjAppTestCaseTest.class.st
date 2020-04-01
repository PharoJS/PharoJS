Class {
	#name : #PjAppTestCaseTest,
	#superclass : #TestCase,
	#category : #'PharoJsTestFramework-Test'
}

{ #category : #testing }
PjAppTestCaseTest >> assertHasArrayAPI: jsArrayLikeClass prefix: prefix [
	| selector |
	selector := prefix, 'first'. "representative selector"
	self assert: (jsArrayLikeClass prototype js_hasOwnProperty: selector)

]

{ #category : #testing }
PjAppTestCaseTest >> resetBridgeTestResources [
	{PjBridgeTestResource. PjDebugBridgeTestResource} do: [ : resourceClass |
		resourceClass reset.
		resourceClass allInstancesDo: [: subInstance | subInstance tearDown]
	]
]

{ #category : #testing }
PjAppTestCaseTest >> setUp [
	super setUp.
	self resetBridgeTestResources
]

{ #category : #testing }
PjAppTestCaseTest >> tearDown [
	super tearDown.
	self resetBridgeTestResources
]

{ #category : #testing }
PjAppTestCaseTest >> testDebug [
	| suite |
	3 timesRepeat: [
		suite := PjMinimalAppTest buildSuite.
		suite debug.
		suite tests do: [: test | self assert: test bridgeResourceClass == PjDebugBridgeTestResource].
		self assert: PjDebugBridgeTestResource current bridge isNil.
		self assert: PjBridgeTestResource current bridge isNil.
	].

]

{ #category : #testing }
PjAppTestCaseTest >> testExportedCodeOfAppRunningJsSideIsComplete [
	| remoteAppClass bridge jsMessage |
	PjBridgeTestResource availableFor: PjNonMinmialAppRunningOnJsTest suite tests anyOne.
	bridge := PjBridgeTestResource current bridge.
	self assert: PjNonMinmialAppRunningOnJsTest appClass == PjHtmlGeneratingCounterApp.
	jsMessage := PjJavascriptMessage receiverId: #Smalltalk selector: #at: arguments: {PjNonMinmialAppRunningOnJsTest appClass name}.
	remoteAppClass := bridge evalMessage: jsMessage.
	self deny: remoteAppClass isNil.
	self deny: remoteAppClass currentInstance isNil 
]

{ #category : #testing }
PjAppTestCaseTest >> testExportedCodeOfAppRunningPharoSideIsMinimal [
	| bridge jsMessage jsSystemDict prefix |
	PjBridgeTestResource availableFor: PjNonMinmialAppRunningOnPharoTest suite tests anyOne.
	bridge := PjBridgeTestResource current bridge.
	self assert: PjNonMinmialAppRunningOnPharoTest appClass == PjHtmlGeneratingCounterApp.
	jsMessage := PjJavascriptMessage receiverId: #Smalltalk selector: #yourself arguments: #().
	jsSystemDict := bridge evalMessage: jsMessage.
	self assert: (jsSystemDict at: PjNonMinmialAppRunningOnJsTest appClass name) isNil.
	prefix := PjNonMinmialAppRunningOnPharoTest appClass pharoJsSelectorPrefix.
	#(Array NodeList HTMLCollection) do: [ : jsArrayLikeClassName |
		|jsArrayLikeClass|
		jsArrayLikeClass := jsSystemDict at: jsArrayLikeClassName.
		self assertHasArrayAPI: jsArrayLikeClass prefix: prefix]

]

{ #category : #testing }
PjAppTestCaseTest >> testPlainRun [
	| result suite |
	3 timesRepeat: [
		suite := PjMinimalAppTest buildSuite.
		result := suite run.
		self assert: result hasPassed.
		suite tests do: [: test | self assert: test bridgeResourceClass == PjBridgeTestResource].
		self assert: PjDebugBridgeTestResource current bridge isNil.
		self assert: PjBridgeTestResource current bridge isNil.
	]
]

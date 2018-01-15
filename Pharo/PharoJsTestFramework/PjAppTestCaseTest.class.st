Class {
	#name : #PjAppTestCaseTest,
	#superclass : #TestCase,
	#category : #'PharoJsTestFramework-Test'
}

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

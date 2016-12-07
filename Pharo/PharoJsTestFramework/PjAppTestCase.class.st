Class {
	#name : #PjAppTestCase,
	#superclass : #TestCase,
	#instVars : [
		'targetPlatform'
	],
	#pools : [
		'PjUniversalGlobals'
	],
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #'suite parameters' }
PjAppTestCase class >> appClass [
	^PjBrowserApplication 
]

{ #category : #'building suites' }
PjAppTestCase class >> buildSuiteFromMethods: testSelectors [
	| suite newSubSuite target |
	suite := self compositeSuiteClass named: self name asString.
	self targetPlatforms do: [ : aPlatform |
		target := self targetForApp: self appClass from: aPlatform.
		newSubSuite := super buildSuiteFromMethods: testSelectors.
		newSubSuite targetPlatform: target.
		suite addSubSuite: newSubSuite.
	]. 
	^suite

]

{ #category : #'building suites' }
PjAppTestCase class >> compositeSuiteClass [
	^PjCompositeTestSuite
]

{ #category : #testing }
PjAppTestCase class >> isAbstract [
	^self == PjAppTestCase or: [ ^super isAbstract ].
]

{ #category : #'instance creation' }
PjAppTestCase class >> run: selector [
	(self buildSuiteFromMethods: {selector}) run.
]

{ #category : #'building suites' }
PjAppTestCase class >> suiteClass [
	^ PjPlatformSpecificTestSuite
]

{ #category : #'building suites' }
PjAppTestCase class >> targetForApp: appClass from: aPlatform [
	| targetName target |
	"Resources are singletons. Since platforms are resources and we want to use the same platform 
	for testing different apps, we generate a new platform subclass for each app."
	targetName := (aPlatform name , appClass name , 'GeneratedForPharoJsAppTest') asSymbol.
	target := Smalltalk classNamed: targetName.
	target ifNotNil: [ ^ target ].
	target := aPlatform
		subclass: targetName
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: #CacheForPharoJsAppTest.
	target currentAppClass: self appClass.
	^ target
]

{ #category : #'suite parameters' }
PjAppTestCase class >> targetPlatforms [
	^{PjWebBrowser}
]

{ #category : #suites }
PjAppTestCase >> asTestSuite [
	| suite |
	suite := super asTestSuite.
	suite targetPlatform: self targetPlatform.
	^suite. 
]

{ #category : #testing }
PjAppTestCase >> assert: aBlock evaluatesTo: expectedResult [
	| actualResult |
	actualResult := self evalBlock: aBlock.
	self assert: actualResult equals: expectedResult.
]

{ #category : #testing }
PjAppTestCase >> assertSmalltalk: smalltalkExpressionString resultsInto: expected [
	| actual | 
	actual := self eval: smalltalkExpressionString.
	self assert: actual equals: expected.
]

{ #category : #accessing }
PjAppTestCase >> bridge [
	^ self targetPlatform current bridge
]

{ #category : #testing }
PjAppTestCase >> cleanUpInstanceVariables [
	| ivsToCleanUp |
	ivsToCleanUp := self class allInstVarNames copyWithoutAll: #('testSelector' 'targetPlatform').
	ivsToCleanUp do: [ :name |
		self instVarNamed: name put: nil ].
]

{ #category : #'UI handling' }
PjAppTestCase >> clickButton: aString [ 
	self dispatchEvent: 'click' to: (document getElementById: aString).
]

{ #category : #'UI handling' }
PjAppTestCase >> dispatchEvent: eventName to: htmlElement [
	htmlElement dispatchEvent: (self newEvent: eventName)
]

{ #category : #testing }
PjAppTestCase >> evalBlock: aBlock [
	^self bridge evalBlock: aBlock
]

{ #category : #'UI handling' }
PjAppTestCase >> newEvent: eventName [
	| event |
	event := document createEvent: 'HTMLEvents'.
   event initEvent: eventName with: true with: true.
	^event

]

{ #category : #testing }
PjAppTestCase >> resetApp [
	self targetPlatform current resetApp.
]

{ #category : #testing }
PjAppTestCase >> setUp [
	super setUp.
	self bridge reset.
	PjBridge bridge: self bridge


]

{ #category : #copying }
PjAppTestCase >> shallowCopy [
	^ super shallowCopy
		targetPlatform: self targetPlatform;
		yourself.
]

{ #category : #accessing }
PjAppTestCase >> targetPlatform [
	^ targetPlatform
]

{ #category : #accessing }
PjAppTestCase >> targetPlatform: anObject [
	targetPlatform := anObject
]

{ #category : #testing }
PjAppTestCase >> tearDown [
	super tearDown.
	PjBridge bridge: nil.


]

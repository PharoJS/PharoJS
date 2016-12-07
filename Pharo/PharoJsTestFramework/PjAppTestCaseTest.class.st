Class {
	#name : #PjAppTestCaseTest,
	#superclass : #TestCase,
	#instVars : [
		'classfactory',
		'testClass',
		'platforms'
	],
	#category : #'PharoJsTestFramework-Test'
}

{ #category : #testing }
PjAppTestCaseTest >> bindTestClassToPlatforms: platforms [
	| writeStream |
	writeStream := WriteStream on: (String new).
	writeStream
		nextPutAll: 'targetPlatforms';
		cr;
		nextPutAll: '^{'.
	platforms do: [ :each | 
		writeStream 
			nextPutAll: each name;
			nextPut: $. 
	].
	writeStream nextPut: $}.
	testClass class compile: writeStream contents.
]

{ #category : #testing }
PjAppTestCaseTest >> setUp [
	super setUp.
	classfactory := ClassFactoryForTestCase new.
	testClass := classfactory silentlyNewSubclassOf: PjAppTestCase instanceVariableNames: '' classVariableNames: ''.

]

{ #category : #testing }
PjAppTestCaseTest >> setUpPlatforms [
	self setUpPlatformsWithSuperclass: PjFakePlatform.
]

{ #category : #testing }
PjAppTestCaseTest >> setUpPlatformsWithSuperclass: aClass [
	platforms := (1 to: 3)
		collect: [ :index | classfactory silentlyNewSubclassOf: aClass instanceVariableNames: '' classVariableNames: '' ].
	self bindTestClassToPlatforms: platforms
]

{ #category : #testing }
PjAppTestCaseTest >> subSuites [
	^testClass suite subSuites
]

{ #category : #testing }
PjAppTestCaseTest >> tearDown [
	super tearDown.
	classfactory cleanUp.

]

{ #category : #testing }
PjAppTestCaseTest >> testDebugRunsForEachSubSuite [
	| platformSuperclass actualPlatformClass |
	platformSuperclass := classfactory silentlyNewSubclassOf: PjFakePlatform instanceVariableNames: '' classVariableNames: ''.
	platformSuperclass class instanceVariableNames: 'debugDone'.
	platformSuperclass class
		compile: 'debugDone
	^debugDone ifNil: [false]';
		compile: 'setDebugDone
	debugDone := true'.
	platformSuperclass
		compile: 'setUp
	self class setDebugDone.
	super setUp.'.
	self setUpPlatformsWithSuperclass: platformSuperclass.
	testClass suite debug.
	platforms do: [ : each |
		actualPlatformClass := testClass targetForApp: testClass appClass from: each.
		self assert: actualPlatformClass debugDone ].
]

{ #category : #testing }
PjAppTestCaseTest >> testEachSubSuitesHasADifferentNames [
	| suiteNames |
	self setUpPlatforms.
	suiteNames := self subSuites collect: [ : subSuite |
		subSuite name.
	].
	self assert: suiteNames asSet size equals: testClass targetPlatforms asSet size.
	testClass targetPlatforms do:[ : platform |
		suiteNames anySatisfy: [: name | platform name endsWith: name capitalized]
	].

]

{ #category : #testing }
PjAppTestCaseTest >> testEachSubSuitesHasADifferentTargetPlatform [
	| actualPlatforms |
	self setUpPlatforms.
	actualPlatforms := self subSuites collect: [ : subSuite |
		subSuite targetPlatform superclass.
	].
	self assert: actualPlatforms asSet equals: platforms asSet.

]

{ #category : #testing }
PjAppTestCaseTest >> testFailIfThereIsNoTargetPlatform [
	testClass class 
		compile: 'targetPlatforms
	^#()'.
	self assert: self subSuites size equals: 0.
	self should: [ testClass suite run ] raise: Exception.	
]

{ #category : #testing }
PjAppTestCaseTest >> testPlatformsAreSetUpUponSuiteRun [
	| rootPlatform |
	rootPlatform := classfactory silentlyNewSubclassOf: PjFakePlatform instanceVariableNames: 'setUpDone' classVariableNames: ''.
	rootPlatform
		compile:
				'setUp
	super setUp.
	setUpDone := true.';
		compile:
				'setUpDone
	^setUpDone'.
	platforms := (1 to: 3)
		collect: [ :index | classfactory silentlyNewSubclassOf: rootPlatform instanceVariableNames: '' classVariableNames: '' ].
	self bindTestClassToPlatforms: platforms.
	testClass suite run.
	platforms do: [ :each | self assert: each current setUpDone equals: true ]
]

{ #category : #testing }
PjAppTestCaseTest >> testPlatformsAreTearedDownUponSuiteRun [
	| rootPlatform  currentPlatforms actualPlatformClass |
	rootPlatform := classfactory silentlyNewSubclassOf: PjFakePlatform instanceVariableNames: 'cleanUpDone' classVariableNames: ''.
	rootPlatform 
	compile: 'tearDown
	super tearDown.
	cleanUpDone := true.';
	compile: 'cleanUpDone
	^cleanUpDone'.
	platforms := (1 to: 3) collect: [: index |  
		classfactory silentlyNewSubclassOf: rootPlatform instanceVariableNames: '' classVariableNames: ''. ].
	self bindTestClassToPlatforms: platforms.
	currentPlatforms := platforms collect: [: each |
		actualPlatformClass := testClass targetForApp: testClass appClass from: each.
		actualPlatformClass current].
	testClass suite run.
	currentPlatforms do: [ : each | 
		self assert: each cleanUpDone equals: true ].

]

{ #category : #testing }
PjAppTestCaseTest >> testPlatformsKnowAppClass [
	self setUpPlatforms.
	testClass suite run.
	self subSuites do: [ :each | self assert: each targetPlatform current appClass == testClass appClass ]
]

{ #category : #testing }
PjAppTestCaseTest >> testSubSuiteTestsCanRebuildSuite [
	| recreatedSuite |
	self setUpPlatforms.
	testClass
		compile: 'testMethod1';
		compile: 'testMethod2'.
	self subSuites do: [: originalSuite |
		originalSuite tests do: [: test |
			self assert: test targetPlatform == originalSuite targetPlatform.
			recreatedSuite := test asTestSuite.
			self assert: recreatedSuite class == originalSuite class.
			self assert: recreatedSuite targetPlatform == originalSuite targetPlatform.]].
]

{ #category : #testing }
PjAppTestCaseTest >> testSubSuitesAndTestsBoundToSamePlatforms [
	self setUpPlatforms.
	testClass
		compile: 'testMethod1';
		compile: 'testMethod2'.
	self subSuites do: [ : subSuite |
		self assert: subSuite targetPlatform notNil.
		subSuite tests do:[: each | each targetPlatform == subSuite targetPlatform].
	]

]

{ #category : #testing }
PjAppTestCaseTest >> testSubSuitesHaveRightNumberOfTests [
	self setUpPlatforms.
	testClass
		compile: 'testMethod1';
		compile: 'testMethod2'.
	self subSuites do: [ : subSuite |
		self assert: subSuite tests size equals: 2.
	]

]

{ #category : #testing }
PjAppTestCaseTest >> testSuiteHasAsManySubSuitsAsTargets [
	self setUpPlatforms.
	self assert: self subSuites size equals: platforms size.

]

{ #category : #testing }
PjAppTestCaseTest >> testSuiteIsComposite [
	self assert: (testClass suite isKindOf: PjCompositeTestSuite).
]

{ #category : #testing }
PjAppTestCaseTest >> testSuitesWithSubsetOfTests [
	| suite actualSelectors |
	self setUpPlatforms.
	testClass
		compile: 'testMethod1';
		compile: 'testMethod2';
		compile: 'testMethod3'.
	suite := testClass buildSuiteFromMethods: #(testMethod2 #testMethod3).
	suite subSuites do: [ : subSuite |
		actualSelectors := subSuite tests collect: [ : each | each selector ].
		self assert: actualSelectors asSet equals: #(testMethod2 #testMethod3) asSet.
	]

]

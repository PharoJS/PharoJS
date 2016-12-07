Extension { #name : #TestCase }

{ #category : #'*PharoJsTestFramework' }
TestCase >> asTestSuite [
	^(self suiteClass named: self name asString)
				addTest: self;
				yourself
]

{ #category : #'*PharoJsTestFramework' }
TestCase >> shallowCopy [
	^ self class selector: testSelector
]

{ #category : #'*PharoJsTestFramework' }
TestCase >> suiteClass [
	^self class suiteClass.
]

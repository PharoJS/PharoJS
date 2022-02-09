Extension { #name : #TestCase }

{ #category : #'*PharoJs-TestFramework' }
TestCase >> asTestSuite [
	^(self suiteClass named: self name asString)
				addTest: self;
				yourself
]

{ #category : #'*PharoJs-TestFramework' }
TestCase >> shallowCopy [
	^ self class selector: testSelector
]

{ #category : #'*PharoJs-TestFramework' }
TestCase >> suiteClass [
	^self class suiteClass.
]

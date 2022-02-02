Class {
	#name : #PjToolsTest,
	#superclass : #TestCase,
	#category : #'PharoJs-Tools-Tests'
}

{ #category : #testing }
PjToolsTest >> testClassAbstract [
	self assert: PjApplication isAbstract.
	self assert: PjDOMApplication isAbstract.
	self assert: PjFileBasedWebApp isAbstract.
	self assert: PjWebApplication isAbstract.
	self assert: PjNodeApplication isAbstract.
	self assert: PjToolsTest1 subclassResponsibilitySet equals: #(m1 m2) asSet.
	self assert: PjToolsTest1 classSubclassResponsibilitySet equals: #(c1) asSet.
	self assert: PjToolsTest1 isAbstract.
	self assert: PjToolsTest2 subclassResponsibilitySet equals: #(m2) asSet.
	self assert: PjToolsTest2 classSubclassResponsibilitySet isEmpty.
	self assert: PjToolsTest2 isAbstract.
	self assert: PjToolsTest3 subclassResponsibilitySet isEmpty.
	self assert: PjToolsTest3 classSubclassResponsibilitySet isEmpty.
	self deny: PjToolsTest3 isAbstract.
	self assert: PjToolsTest2b subclassResponsibilitySet isEmpty.
	self assert: PjToolsTest2b classSubclassResponsibilitySet equals: #(c1) asSet.
	self assert: PjToolsTest2b isAbstract.
]

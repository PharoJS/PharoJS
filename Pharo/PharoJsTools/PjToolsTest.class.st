Class {
	#name : #PjToolsTest,
	#superclass : #TestCase,
	#category : #'PharoJsTools-Tests'
}

{ #category : #testing }
PjToolsTest >> testClassAbstract [
	self assert: PjApplication isAbstract.
	self assert: PjToolsTest1 isAbstract.
	self assert: PjToolsTest2 isAbstract.
	self deny: PjToolsTest3 isAbstract.
	self assert: PjToolsTest2b isAbstract.

	
]

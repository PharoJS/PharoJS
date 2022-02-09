Class {
	#name : #PjToolsTest,
	#superclass : #TestCase,
	#category : #'PharoJs-Tools-Tests-Base'
}

{ #category : #testing }
PjToolsTest >> testClassAbstract [
	"Test that subclasses of PjApplication return true for #isAbstract although they might 
	 not necessarily implement an #isAbstract method. Having a single subclass responsibility
	 makes them an abstract class already."
		
	self assert: PjApplication isAbstract.
	self assert: PjDOMApplication isAbstract.
	self assert: PjFileBasedWebApp isAbstract.
	self assert: PjWebApplication isAbstract.
	self assert: PjNodeApplication isAbstract.
	
	self assert: PjToolsTestClass1 subclassResponsibilitySet equals: #(m1 m2) asSet.
	self assert: PjToolsTestClass1 classSubclassResponsibilitySet equals: #(c1) asSet.
	self assert: PjToolsTestClass1 isAbstract.
	
	self assert: PjToolsTestClass2 subclassResponsibilitySet equals: #(m2) asSet.
	self assert: PjToolsTestClass2 classSubclassResponsibilitySet isEmpty.
	self assert: PjToolsTestClass2 isAbstract.
	
	self assert: PjToolsTestClass3 subclassResponsibilitySet isEmpty.
	self assert: PjToolsTestClass3 classSubclassResponsibilitySet isEmpty.
	self deny: PjToolsTestClass3 isAbstract.
	
	self assert: PjToolsTestClass2b subclassResponsibilitySet isEmpty.
	self assert: PjToolsTestClass2b classSubclassResponsibilitySet equals: #(c1) asSet.
	self assert: PjToolsTestClass2b isAbstract
]

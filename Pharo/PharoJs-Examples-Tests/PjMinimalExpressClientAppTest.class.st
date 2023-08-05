Class {
	#name : #PjMinimalExpressClientAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #'suite parameters' }
PjMinimalExpressClientAppTest class >> appClass [
	^PjMinimalExpressClientApp 
]

{ #category : #accessing }
PjMinimalExpressClientAppTest >> testDataAccess [

	| display |
	display := app elementAt: #dataDisplaySpan.
	self assert: display textContent isEmpty.
	(app elementAt: #dataInput) value: '42'.
	self clickElementById: #postDataButton.
	self clickElementById: #getDataButton.
	self waitUntil:[ display textContent = '42']
]

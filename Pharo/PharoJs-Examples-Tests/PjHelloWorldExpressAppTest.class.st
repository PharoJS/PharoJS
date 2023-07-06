Class {
	#name : #PjHelloWorldExpressAppTest,
	#superclass : #PjAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #'suite parameters' }
PjHelloWorldExpressAppTest class >> appClass [

	^ PjHelloWorldExpressApp 
]

{ #category : #tests }
PjHelloWorldExpressAppTest >> testHttpGet [

	| response |
	response := ZnEasy get: 'http://localhost:4321/'.
	self assert: response contents equals: 'ExpressJS says hello to PharoJS!'
]

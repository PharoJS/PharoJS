Class {
	#name : #PjMinimalAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-TestFramework-Test'
}

{ #category : #'suite parameters' }
PjMinimalAppTest class >> appClass [
	^PjMinimalApp.
]

{ #category : #tests }
PjMinimalAppTest >> testAppReady [
	self assert: [1+2] evaluatesTo: 3
]

{ #category : #tests }
PjMinimalAppTest >> testResetApp [
	self evalBlock: [window instVarNamed:#forTest put: 3].
	self assert: [window instVarNamed:#forTest] evaluatesTo: 3.
	self resetApp.
	self assert: [window instVarNamed:#forTest] evaluatesTo: nil.
]

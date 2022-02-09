Class {
	#name : #PjNonMinmialAppRunningOnPharoTest,
	#superclass : #PjWebAppTestCase,
	#category : #'PharoJs-TestFramework-Test'
}

{ #category : #'suite parameters' }
PjNonMinmialAppRunningOnPharoTest class >> appClass [
	^PjHtmlGeneratingCounterApp
]

{ #category : #testing }
PjNonMinmialAppRunningOnPharoTest >> testAlwaysSucceed [
	self assert: true
]

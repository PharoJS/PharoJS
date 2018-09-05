Class {
	#name : #PjNonMinmialAppRunningOnPharoTest,
	#superclass : #PjWebAppTestCase,
	#category : #'PharoJsTestFramework-Test'
}

{ #category : #'suite parameters' }
PjNonMinmialAppRunningOnPharoTest class >> appClass [
	^PjHtmlGeneratingCounterApp
]

{ #category : #testing }
PjNonMinmialAppRunningOnPharoTest >> testAlwaysSucceed [
	self assert: true
]

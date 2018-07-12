Class {
	#name : #PjNonMinmialAppTest,
	#superclass : #PjWebAppTestCase,
	#category : #'PharoJsTestFramework-Test'
}

{ #category : #'suite parameters' }
PjNonMinmialAppTest class >> appClass [
	^PjHtmlGeneratingCounterApp
]

{ #category : #testing }
PjNonMinmialAppTest >> testAlwaysSucceed [
	self assert: true
]

Class {
	#name : #PjAppFolderNameIncludesSpaceTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJsBridgeTest-Tests'
}

{ #category : #'suite parameters' }
PjAppFolderNameIncludesSpaceTest class >> appClass [
	^PjAppWithFolderNameIncludesSpace
]

{ #category : #testing }
PjAppFolderNameIncludesSpaceTest >> testConnectionEstablished [
	self assert: self bridge isConnected
]

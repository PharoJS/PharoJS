Class {
	#name : #PjAppFolderNameIncludesSpaceTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #'suite parameters' }
PjAppFolderNameIncludesSpaceTest class >> appClass [
	^PjAppWithFolderNameIncludesSpace
]

{ #category : #tests }
PjAppFolderNameIncludesSpaceTest >> testConnectionEstablished [
	self assert: self bridge isConnected
]

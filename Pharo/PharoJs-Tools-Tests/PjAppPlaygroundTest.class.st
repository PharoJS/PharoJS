Class {
	#name : #PjAppPlaygroundTest,
	#superclass : #PjPlaygroundTest,
	#traits : 'PjTWaitUntilReady',
	#classTraits : 'PjTWaitUntilReady classTrait',
	#category : #'PharoJs-Tools-Tests-Playground'
}

{ #category : #asserting }
PjAppPlaygroundTest class >> shouldInheritSelectors [
	^true
]

{ #category : #tests }
PjAppPlaygroundTest >> setUpPlayground [

	playground := PjMinimalApp playground.
	self waitUntil: [ playground bridge isConnected ]
]

{ #category : #tests }
PjAppPlaygroundTest >> testVerifyTitle [

	self assert: (playground title includesSubstring: 'PharoJS').
	self assert: (playground title includesSubstring: 'PjMinimalApp')
]

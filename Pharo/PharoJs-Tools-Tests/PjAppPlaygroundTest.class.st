Class {
	#name : #PjAppPlaygroundTest,
	#superclass : #TestCase,
	#traits : 'PjTWaitUntilReady',
	#classTraits : 'PjTWaitUntilReady classTrait',
	#instVars : [
		'playground'
	],
	#category : #'PharoJs-Tools-Tests-Playground'
}

{ #category : #tests }
PjAppPlaygroundTest >> eval: aString [
	playground bridge eval: aString
]

{ #category : #tests }
PjAppPlaygroundTest >> setUp [

	super setUp.
	playground := PjMinimalApp playground.
	self waitUntil: [ playground bridge isConnected ]
]

{ #category : #tests }
PjAppPlaygroundTest >> tearDown [

	super tearDown.
	playground window close
]

{ #category : #tests }
PjAppPlaygroundTest >> testReadJsGlobal [

	| result |
	self shouldnt: [ result := self eval: 'window.' ] raise: Error.
	self assert: (result isKindOf: PjProxy).
	self assert: result asJSON equals: #window
]

{ #category : #tests }
PjAppPlaygroundTest >> testVerifyTitle [

	self assert: (playground title includesSubstring: 'PharoJS').
	self assert: (playground title includesSubstring: 'PjMinimalApp')
]

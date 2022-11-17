Class {
	#name : #PjMinimalNodeApplicationTest,
	#superclass : #PjAppTestCase,
	#category : #'PharoJs-Examples-Tests-Minimal'
}

{ #category : #'suite parameters' }
PjMinimalNodeApplicationTest class >> appClass [ 
	^PjMinimalNodeApplication 
]

{ #category : #tests }
PjMinimalNodeApplicationTest >> exportedAppJsFileChangeTime [

	^ self appClass appFullJsFileName resolve changeTime
]

{ #category : #tests }
PjMinimalNodeApplicationTest >> testArithmeticOperations [
	self assert: [ 1+2 ] evaluatesTo: 3.
	self assert: [ 32 / 8 ] evaluatesTo: 4.
]

{ #category : #tests }
PjMinimalNodeApplicationTest >> testCounter [
	| jsCounter |
	jsCounter := self evalBlock: [PjCounter new].
	3 timesRepeat: [jsCounter increment].
	self assert: jsCounter count equals: 3
]

{ #category : #tests }
PjMinimalNodeApplicationTest >> testLoadClass [
	| jsCounter |
	jsCounter := self evalBlock: [ PjCounter new ].
	self assert: jsCounter count equals: 0.
	1 to: 3 do: [ : expectedCount | 
		jsCounter increment.
		self assert: jsCounter count equals: expectedCount
	]
]

{ #category : #tests }
PjMinimalNodeApplicationTest >> testResetApp [

	| initialChangeTime latestChangeTime |
	self evalBlock: [ global instVarNamed: #forTest put: 3 ].
	self assert: [ global instVarNamed: #forTest ] evaluatesTo: 3.
	initialChangeTime := self exportedAppJsFileChangeTime.
	self resetApp.
	self assert: [ global instVarNamed: #forTest ] evaluatesTo: nil.
	latestChangeTime := self exportedAppJsFileChangeTime.
	self assert: latestChangeTime equals: initialChangeTime
]

Class {
	#name : #PjCounterTest,
	#superclass : #TestCase,
	#instVars : [
		'counter'
	],
	#category : #'PharoJs-Examples-Tests-Counter'
}

{ #category : #running }
PjCounterTest >> setUp [
	counter := PjCounter new
]

{ #category : #tests }
PjCounterTest >> testIncrementIncreasesCountBy1 [
	1 to: 10 do: [ : expectedCount |
			counter increment.
		self assert: counter count equals: expectedCount
	]
]

{ #category : #tests }
PjCounterTest >> testInitialCountIs0 [
	self assert: counter count equals: 0
]

{ #category : #tests }
PjCounterTest >> testResetSetsCountTo0 [
	3 timesRepeat: [counter increment].
	counter reset.
	self assert: counter count equals: 0
]

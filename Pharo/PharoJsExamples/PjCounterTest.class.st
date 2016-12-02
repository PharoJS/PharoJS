Class {
	#name : #PjCounterTest,
	#superclass : #TestCase,
	#instVars : [
		'counter'
	],
	#category : #'PharoJsExamples-Counter'
}

{ #category : #testing }
PjCounterTest >> setUp [
	counter := PjCounter new
]

{ #category : #testing }
PjCounterTest >> testIncrementIncreasesCountBy1 [
	1 to: 10 do: [ : expectedCount |
			counter increment.
		self assert: counter count equals: expectedCount
	]

]

{ #category : #testing }
PjCounterTest >> testInitialCountIs0 [
	self assert: counter count equals: 0
]

{ #category : #testing }
PjCounterTest >> testResetSetsCountTo0 [
	3 timesRepeat: [counter increment].
	counter reset.
	self assert: counter count equals: 0

]

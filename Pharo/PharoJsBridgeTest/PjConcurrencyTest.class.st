Class {
	#name : #PjConcurrencyTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsBridgeTest-Tests'
}

{ #category : #tests }
PjConcurrencyTest >> testTwoPharoThreads [
	| resultsA threadA repetitionsCount resultsB threadB threads millisecondsInterval|
	self evalBlock: [ window at: #a put: 1 ].
	self evalBlock: [ window at: #b put: 2 ].
	repetitionsCount := 20.
	millisecondsInterval := 1 to: 10.
	resultsA := OrderedCollection new.
	threadA := [
			repetitionsCount timesRepeat: [
				millisecondsInterval atRandom milliSeconds wait.
				resultsA add: (self evalBlock: [window at: #a])]
			] newProcess.
	resultsB := OrderedCollection new.
	threadB := [
		repetitionsCount timesRepeat: [
			millisecondsInterval atRandom milliSeconds wait.
			resultsB add: (self evalBlock: [window at: #b])]
		] newProcess.
	threads := {threadA. threadB}.
	threads do: [ : each | each priority: Processor userBackgroundPriority ].
	threads do: #resume.
	500 milliSeconds wait.
	{resultsA. resultsB} with: #(1 2) do: [ : each : expectedValue |
		self assert: each size > 1.
		self assert: each asSet size equals: 1.
		self assert: each anyOne equals: expectedValue ].

]

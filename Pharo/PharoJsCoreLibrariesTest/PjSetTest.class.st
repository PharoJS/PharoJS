Class {
	#name : #PjSetTest,
	#superclass : #PjBridgeTestCase,
	#instVars : [
		'set'
	],
	#category : #PharoJsCoreLibrariesTest
}

{ #category : #testing }
PjSetTest >> setUp [
	super setUp.
	set := self evalBlock: [ Set new ]
]

{ #category : #testing }
PjSetTest >> testElementAddedFirstSeveralTimesShowsUpOnlyOnce [
	3 timesRepeat: [ set addFirst: 42 ].
	self assert: set size equals: 1.
	self assert: (set includes: 42).

]

{ #category : #testing }
PjSetTest >> testElementAddedLastSeveralTimesShowsUpOnlyOnce [
	3 timesRepeat: [ set addLast: 42 ].
	self assert: set size equals: 1.
	self assert: (set includes: 42).

]

{ #category : #testing }
PjSetTest >> testElementAddedSeveralTimesShowsUpOnlyOnce [
	3 timesRepeat: [ set add: 42 ].
	self assert: set size equals: 1.
	self assert: (set includes: 42).

]

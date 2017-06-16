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

{ #category : #testing }
PjSetTest >> testRemoveAll [
	set addAll: #(1 2 3 4 5).
	set removeAll: #(1 5).
	self assert: set size equals: 3.
	#(2 3 4) do: [ : expectedElement |
		self assert: (set includes: expectedElement)
	].
	set removeAll.
	self assert: set isEmpty.
]

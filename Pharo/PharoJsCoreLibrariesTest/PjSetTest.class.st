Class {
	#name : #PjSetTest,
	#superclass : #PjBridgeTestCase,
	#instVars : [
		'set'
	],
	#category : #'PharoJsCoreLibrariesTest-Collections'
}

{ #category : #running }
PjSetTest >> setUp [
	super setUp.
	set := self evalBlock: [ Set new ]
]

{ #category : #testing }
PjSetTest >> testCircularReference [
	self deny: (set includes: set).
	set add: 'A'.
	self deny: (set includes: set).
	set add: set.
	self assert: (set includes: set).
	self assert: set size equals: 2.
]

{ #category : #testing }
PjSetTest >> testConverstionToSet [
	self assert: set asSet identicalTo: set
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
PjSetTest >> testLike [
	set addAll: #(1 2 3 4 5).
	self assert: (set like: 4) equals: 4.
	self assert: (set like: 42) equals: nil.
	self assert: (set like: 4 ifAbsent: [ 3+4 ]) equals: 4.
	self assert: (set like: 42 ifAbsent: [ 3+4 ]) equals: 7.
]

{ #category : #testing }
PjSetTest >> testRemove [
	set addAll: #(1 2 3 4 5).
	set remove: 3 ifAbsent: [ ].
	set remove: 42 ifAbsent: [ ].
	self assert: set size equals: 4.
	#(1 2 4 5) do: [ : expectedElement |
		self assert: (set includes: expectedElement)
	].
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

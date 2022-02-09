Class {
	#name : #PjSetTest,
	#superclass : #PjBridgeTestCase,
	#instVars : [
		'set'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #running }
PjSetTest >> setUp [
	super setUp.
	set := self evalBlock: [ Set new ]
]

{ #category : #tests }
PjSetTest >> testCircularReference [
	self deny: (set includes: set).
	set add: 'A'.
	self deny: (set includes: set).
	set add: set.
	self assert: (set includes: set).
	self assert: set size equals: 2.
]

{ #category : #tests }
PjSetTest >> testConverstionToSet [
	self assert: set asSet identicalTo: set
]

{ #category : #tests }
PjSetTest >> testElementAddedFirstSeveralTimesShowsUpOnlyOnce [
	3 timesRepeat: [ set addFirst: 42 ].
	self assert: set size equals: 1.
	self assert: (set includes: 42).
]

{ #category : #tests }
PjSetTest >> testElementAddedLastSeveralTimesShowsUpOnlyOnce [
	3 timesRepeat: [ set addLast: 42 ].
	self assert: set size equals: 1.
	self assert: (set includes: 42).
]

{ #category : #tests }
PjSetTest >> testElementAddedSeveralTimesShowsUpOnlyOnce [
	3 timesRepeat: [ set add: 42 ].
	self assert: set size equals: 1.
	self assert: (set includes: 42).
]

{ #category : #tests }
PjSetTest >> testLike [
	set addAll: #(1 2 3 4 5).
	self assert: (set like: 4) equals: 4.
	self assert: (set like: 42) equals: nil.
	self assert: (set like: 4 ifAbsent: [ 3+4 ]) equals: 4.
	self assert: (set like: 42 ifAbsent: [ 3+4 ]) equals: 7.
]

{ #category : #tests }
PjSetTest >> testRemove [
	set addAll: #(1 2 3 4 5).
	set remove: 3 ifAbsent: [ ].
	set remove: 42 ifAbsent: [ ].
	self assert: set size equals: 4.
	#(1 2 4 5) do: [ : expectedElement |
		self assert: (set includes: expectedElement)
	].
]

{ #category : #tests }
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

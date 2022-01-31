Class {
	#name : #PjSortedCollectionTest,
	#superclass : #PjBridgeTestCase,
	#instVars : [
		'collection'
	],
	#category : #'PharoJsCoreLibrariesTest-Collections'
}

{ #category : #testing }
PjSortedCollectionTest >> atRandomAddAll: elements [
	| toInsert |
	toInsert := Set withAll: elements.
 	toInsert size timesRepeat: [
		|inserted|
		inserted := toInsert atRandom.
		collection add: inserted.
		toInsert remove: inserted].
]

{ #category : #running }
PjSortedCollectionTest >> setUp [
	super setUp.
	collection := self evalBlock: [ SortedCollection new ]
]

{ #category : #testing }
PjSortedCollectionTest >> testAllButLast [
	| allButLast |
	1 to: 4 do: [:each|
		collection add: each].
	allButLast := collection allButLast.
	self assert: allButLast size equals: 3.
	1 to: 3 do: [ : each |
		self assert: (allButLast at: each) equals: each.
	].
]

{ #category : #testing }
PjSortedCollectionTest >> testCollect [
	collection := self evalBlock: [ 
		|s|
		s := SortedCollection  new.
		s add: 3; add: 1.
		s collect: [: each | each ]].
	self assert: collection size equals: 2.
	self assert: collection first equals: 1.
	self assert: collection last equals: 3.
]

{ #category : #testing }
PjSortedCollectionTest >> testReSortingNumbers [
	self evalBlock: [ collection sortBlock: [ : a : b | a <= b ] ].
	self atRandomAddAll: (1 to: 10).
	self evalBlock: [ collection sortBlock: [ : a : b | a >= b ] ].
	(1 to: 10) with: (1 to: 10) reversed do: [ : index : expectedValue |
		self assert: (collection at: index) equals: expectedValue ]
]

{ #category : #testing }
PjSortedCollectionTest >> testShallowCopy [
	| clone |
	self atRandomAddAll: (1 to: 10).
	clone := collection copy.
	self assert: clone size equals: 10.
	(1 to: 10) do: [ : index |
		self assert: (clone at: index) equals: index ]
]

{ #category : #testing }
PjSortedCollectionTest >> testSortingNumbersGreaterFirst [
	self evalBlock: [ collection sortBlock: [ : a : b | a >=b ] ].
	self atRandomAddAll: (1 to: 10).
	(1 to: 10) with: (1 to: 10) reversed do: [ : index : expectedValue |
		self assert: (collection at: index) equals: expectedValue ]
]

{ #category : #testing }
PjSortedCollectionTest >> testSortingNumbersSmallerFirst [
	self atRandomAddAll: (1 to: 10).
	(1 to: 10) do: [ : index |
		self assert: (collection at: index) equals: index ]
]

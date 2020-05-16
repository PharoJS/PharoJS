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

{ #category : #testing }
PjSortedCollectionTest >> setUp [
	super setUp.
	collection := self evalBlock: [ SortedCollection new ]
]

{ #category : #testing }
PjSortedCollectionTest >> testAddAll [
	collection := self evalBlock: [ SortedCollection new addAll: #(3 6 1 4 9 2 7 8 5 10);yourself ].	
	(1 to: 10) do: [ : index |
		self assert: (collection at: index) equals: index ]

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
PjSortedCollectionTest >> testAsSortedCollection [
	collection := self evalBlock: [ #(3 6 1 4 9 2 7 8 5 10) asSortedCollection ].	
	(1 to: 10) do: [ : index |
		self assert: (collection at: index) equals: index ]

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
PjSortedCollectionTest >> testFromDictionary [
	self assertEquivalent: [|d|
		d := Dictionary new.
		d at: #x put: #x.
		d at: #a put: #a.
		d at: #y put: #y.
		d at: #w put: #w.
		d at: #e put: #e.
		d at: #b put: #b.
		d asSortedCollection
		].

]

{ #category : #testing }
PjSortedCollectionTest >> testFromLargeArray [
	self assertEquivalent: [
		((130 to: 90 by: -1) collect: #asString) asSortedCollection.
	].

]

{ #category : #testing }
PjSortedCollectionTest >> testObjects [
	self assertEquivalent: [
		| s |
		s := SortedCollection new.
		1 to: 10 do: [: each |
			s add: (PjMinimalApp data: each % 3) ].
		s collect: #data
	].

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

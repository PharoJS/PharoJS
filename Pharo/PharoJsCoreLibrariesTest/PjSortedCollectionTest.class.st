Class {
	#name : #PjSortedCollectionTest,
	#superclass : #PjBridgeTestCase,
	#instVars : [
		'collection'
	],
	#category : #PharoJsCoreLibrariesTest
}

{ #category : #testing }
PjSortedCollectionTest >> setUp [
	super setUp.
	collection := self evalBlock: [ SortedCollection new ]
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
PjSortedCollectionTest >> testShallowCopy [
	| clone |
	#(33 22 11) do: [: each | collection add: each].
	clone := collection copy.
	self assert: clone size equals: 3.
	#(11 22 33) withIndexDo: [ : each : index |
		self assert: (clone at: index) equals: each
		 ].

]

{ #category : #testing }
PjSortedCollectionTest >> testSortingNumbers [
	(1 to: 3) reverseDo: [: each | collection add: each].
	self assert: collection size equals: 3.
	self assert: collection first equals: 1.
	self assert: collection last equals: 3.
	
]

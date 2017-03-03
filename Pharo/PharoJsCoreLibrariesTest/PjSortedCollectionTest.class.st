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
PjSortedCollectionTest >> testSortingNumbers [
	(1 to: 3) reverseDo: [: each | collection add: each].
	self assert: collection size equals: 3.
	self assert: collection first equals: 1.
	self assert: collection last equals: 3.
	
]

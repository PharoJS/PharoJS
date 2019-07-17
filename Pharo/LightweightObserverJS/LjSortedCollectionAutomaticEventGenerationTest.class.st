Class {
	#name : #LjSortedCollectionAutomaticEventGenerationTest,
	#superclass : #LjSequenceableCollectionAutomaticEventGenerationTest,
	#category : #'LightweightObserverJS-Tests'
}

{ #category : #testing }
LjSortedCollectionAutomaticEventGenerationTest >> resetCollection [
	self evalBlock: [ subject collection: SortedCollection new ]
]

{ #category : #testing }
LjSortedCollectionAutomaticEventGenerationTest >> testAddLastElement [
	self evalBlock: [subject 
		afterAddToCollection: #collection 
		do: [ : newValue : index | 
			window instVarNamed: #lastAddedValue put: newValue.
			window instVarNamed: #lastIndex put: index]].
	subject collection addLast: #sunday.
	self assert: window lastAddedValue equals: #sunday.
	self assert: window lastIndex equals: 1.
	subject collection addLast: #saturday.
	self assert: window lastAddedValue equals: #saturday.
	self assert: window lastIndex equals: 2

]

{ #category : #testing }
LjSortedCollectionAutomaticEventGenerationTest >> testAddOneElementWithIndex [
	self evalBlock: [
		subject afterAddToCollection: #collection do: [ : newValue : newIndex| 
			window instVarNamed: #lastAddedValue put: newValue.
			window instVarNamed: #lastIndex put: newIndex.
			]].
	subject collection add: #monday.
	self assert: window lastAddedValue equals: #monday.
	self assert: window lastIndex equals: 1.
	subject collection add: #sunday.
	self assert: window lastAddedValue equals: #sunday.
	self assert: window lastIndex equals: 2.
	subject collection add: #saturday.
	self assert: window lastAddedValue equals: #saturday.
	self assert: window lastIndex equals: 2.
	subject collection add: #wednesday.
	self assert: window lastAddedValue equals: #wednesday.
	self assert: window lastIndex equals: 4.

]

{ #category : #testing }
LjSortedCollectionAutomaticEventGenerationTest >> testArbitraryChangeWithLastElementManipulation [
	window instVarNamed: #changeCount put: 0.
	self evalBlock: [subject 
		afterChangeOfCollection: #collection 
		do: [window changeCount: window changeCount + 1]].
	subject collection add: 10.
	self assert: window changeCount equals: 1.
	subject collection addLast: 5.
	self assert: window changeCount equals: 2.
	subject collection addLast: 4.
	self assert: window changeCount equals: 3.
	subject collection remove: 10.
	self assert: window changeCount equals: 4.

]

{ #category : #testing }
LjSortedCollectionAutomaticEventGenerationTest >> testElementsStaySorted [
	self evalBlock: [
		subject afterChangeOfCollection: #collection do: [].
		#(10 5 1) do: [ : each |
			subject collection add: each ]].
	self assert: subject collection first equals: 1.
	self assert: subject collection last equals: 10.
]

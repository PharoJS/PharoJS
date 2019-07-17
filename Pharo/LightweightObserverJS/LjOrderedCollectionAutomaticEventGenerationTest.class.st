Class {
	#name : #LjOrderedCollectionAutomaticEventGenerationTest,
	#superclass : #LjSequenceableCollectionAutomaticEventGenerationTest,
	#category : #'LightweightObserverJS-Tests'
}

{ #category : #testing }
LjOrderedCollectionAutomaticEventGenerationTest >> resetCollection [
	self evalBlock: [ subject collection: OrderedCollection new ]
]

{ #category : #testing }
LjOrderedCollectionAutomaticEventGenerationTest >> testAddFirstAndLastElement [
	self evalBlock: [subject 
		afterAddToCollection: #collection 
		do: [ : newValue : newIndex | 
			window instVarNamed: #lastAddedValue put: newValue.
			window instVarNamed: #lastIndex put: newIndex]].
	subject collection addLast: #saturday.
	self assert: window lastAddedValue equals: #saturday.
	self assert: window lastIndex equals: 1.
	subject collection addFirst: #sunday.
	self assert: window lastAddedValue equals: #sunday.
	self assert: window lastIndex equals: 1.
		subject collection addLast: #monday.
	self assert: window lastAddedValue equals: #monday.
	self assert: window lastIndex equals: 3.

]

{ #category : #testing }
LjOrderedCollectionAutomaticEventGenerationTest >> testAddOneElementWithIndex [
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

]

{ #category : #testing }
LjOrderedCollectionAutomaticEventGenerationTest >> testArbitraryChangeWithFirstLastElementManipulation [
	window instVarNamed: #changeCount put: 0.
	self evalBlock: [subject 
		afterChangeOfCollection: #collection 
		do: [window changeCount: window changeCount + 1]].
	subject collection add: #monday.
	self assert: window changeCount equals: 1.
	subject collection addFirst: #sunday.
	self assert: window changeCount equals: 2.
	subject collection addLast: #saturday.
	self assert: window changeCount equals: 3.
	subject collection remove: #monday.
	self assert: window changeCount equals: 4.
	subject collection at: 1 put: #friday.
	self assert: window changeCount equals: 5.

]

{ #category : #testing }
LjOrderedCollectionAutomaticEventGenerationTest >> testAtPut [
	self evalBlock: [
		subject collection addAll: { 11. 21. 31. }.
		subject 
			afterReplaceInCollection: #collection 
			do: [ : index : addedValue : removedValue| 
				window instVarNamed: #lastIndex put: index.
				window instVarNamed: #lastRemovedValue put: removedValue.
				window instVarNamed: #lastAddedValue put: addedValue]
	].
	self evalBlock: [subject collection at: 1 put: 10].
	self assert: window lastRemovedValue equals: 11.
	self assert: window lastAddedValue equals: 10.
	self assert: window lastIndex equals: 1.
	self evalBlock: [subject collection at: 2 put: 20].
	self assert: window lastRemovedValue equals: 21.
	self assert: window lastAddedValue equals: 20.
	self assert: window lastIndex equals: 2.
	
]

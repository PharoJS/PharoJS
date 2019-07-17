Class {
	#name : #LjElasticCollectionAutomaticEventGenerationTest,
	#superclass : #LjAutomaticEventGenerationTest,
	#category : #'LightweightObserverJS-Tests'
}

{ #category : #testing }
LjElasticCollectionAutomaticEventGenerationTest class >> isAbstract [
	^self == LjElasticCollectionAutomaticEventGenerationTest
]

{ #category : #testing }
LjElasticCollectionAutomaticEventGenerationTest >> assertRemoteCollection: proxyOnCollection hasSameElements: expectedElements [
	self assert: proxyOnCollection size equals: expectedElements size.
	expectedElements do: [ : element |
		self assert: (proxyOnCollection  includes: element)
	]
	
]

{ #category : #testing }
LjElasticCollectionAutomaticEventGenerationTest >> resetCollection [
	self subclassResponsibility
]

{ #category : #testing }
LjElasticCollectionAutomaticEventGenerationTest >> setUp [
	super setUp.
	self resetCollection
]

{ #category : #testing }
LjElasticCollectionAutomaticEventGenerationTest >> testAddManyElements [
	| recordedObjects |
	recordedObjects := self evalBlock: [OrderedCollection new].
	self evalBlock: [
		subject afterAddToCollection: #collection do: [ : newValue | recordedObjects add: newValue]].
	self evalBlock: [subject collection addAll: #(10 20 30)].
	self assertRemoteCollection: recordedObjects hasSameElements: #(10 20 30).
	
]

{ #category : #testing }
LjElasticCollectionAutomaticEventGenerationTest >> testAddOneElement [	
	self evalBlock: [
		subject afterAddToCollection: #collection do: [ : newValue | 
			window instVarNamed: #lastAddedValue put: newValue]].
	subject collection add: #monday.
	self assert: window lastAddedValue equals: #monday.
	subject collection add: #sunday.
	self assert: window lastAddedValue equals: #sunday.

]

{ #category : #testing }
LjElasticCollectionAutomaticEventGenerationTest >> testArbitraryChange [
	window instVarNamed: #changeCount put: 0.
	self evalBlock: [subject 
			afterChangeOfCollection: #collection 
			do: [window changeCount: window changeCount + 1]].
	subject collection add: #monday.
	self assert: window changeCount equals: 1.
	subject collection remove: #monday.
	self assert: window  changeCount equals: 2.

]

{ #category : #testing }
LjElasticCollectionAutomaticEventGenerationTest >> testRemoveManyObjects [
	| recordedObjects |
	self evalBlock: [subject collection addAll: { 11. 12. 13. 20. 31. 32. 33 }].
	recordedObjects := self evalBlock: [OrderedCollection new].
	self evalBlock: [subject 
		afterRemoveFromCollection: #collection 
		do: [ : newValue | recordedObjects add: newValue]].
	self evalBlock: [subject collection removeAll: {11. 13. 20. 32}].
	self assert: recordedObjects size equals: 4.
	self assertRemoteCollection: recordedObjects hasSameElements: {11. 13. 20. 32}.
]

{ #category : #testing }
LjElasticCollectionAutomaticEventGenerationTest >> testRemoveOneElement [
	self evalBlock: [
		subject collection addAll: { 11. 12. 13. 20. 31. 32. 33 }.
		subject 
			afterRemoveFromCollection: #collection 
			do: [ : removedValue | window instVarNamed: #lastRemovedValue put: removedValue].
		subject collection remove: 100 ifAbsent: []
	].
	self assert: (window instVarNamed: #lastRemovedValue) isNil.
	subject collection remove: 20.
	self assert: window lastRemovedValue equals: 20.
	subject collection remove: 13.
	self assert: window lastRemovedValue equals: 13.

]

{ #category : #testing }
LjElasticCollectionAutomaticEventGenerationTest >> testRemoveOneElementWithoutEventDispatch [
	subject collection addAll: { 11. 12. 13. 20. 31. 32. 33 }.
	self 
		shouldnt: [
			subject collection remove: 100 ifAbsent: [].
			subject collection remove: 11.
			subject collection remove: 33.
			] 
		raise: Error.

]

{ #category : #testing }
LjElasticCollectionAutomaticEventGenerationTest >> testReset [
	window instVarNamed: #doneAddition put: false.
	self evalBlock: [
		subject afterAddToCollection: #collection do: [window doneAddition: true].].
	self resetCollection.	
	self evalBlock: [subject collection addAll: #(1 2)].
	self assert: window doneAddition.
	
]

Class {
	#name : #LjSequenceableCollectionAutomaticEventGenerationTest,
	#superclass : #LjElasticCollectionAutomaticEventGenerationTest,
	#category : #'LightweightObserverJS-Tests'
}

{ #category : #testing }
LjSequenceableCollectionAutomaticEventGenerationTest class >> isAbstract [
	^self == LjSequenceableCollectionAutomaticEventGenerationTest
]

{ #category : #testing }
LjSequenceableCollectionAutomaticEventGenerationTest >> testRemoveElementByIndex [
	self evalBlock: [
		subject collection addAll: { 11. 12. 13. 20. 31. 32. 33 }.
		subject 
			afterRemoveFromCollection: #collection 
			do: [ : removedValue | window instVarNamed: #lastRemovedValue put: removedValue].
	].
	subject collection removeFirst.
	self assert: window lastRemovedValue equals: 11.
	subject collection removeLast.
	self assert: window lastRemovedValue equals: 33.
	subject collection removeAt: 2.
	self assert: window lastRemovedValue equals: 13.

]

{ #category : #testing }
LjSequenceableCollectionAutomaticEventGenerationTest >> testRemoveElementByIndexWithoutEventDispatch [
	self evalBlock: [
		subject collection addAll: { 11. 12. 13. 20. 31. 32. 33 }].
	self 
		shouldnt: [
			subject collection removeFirst.
			subject collection removeLast.
			subject collection removeAt: 2.
			] 
		raise: Error.

]

{ #category : #testing }
LjSequenceableCollectionAutomaticEventGenerationTest >> testRemoveOneElementWithIndex [
	self evalBlock: [
		subject collection addAll: { 11. 12. 13. 20. 31. 32. 33 }.
		subject 
			afterRemoveFromCollection: #collection 
			do: [ : removedValue :index | 
				window instVarNamed: #lastRemovedValue put: removedValue.
				window instVarNamed: #lastIndex put: index].
		subject collection remove: 100 ifAbsent: []
	].
	self assert: (window instVarNamed: #lastRemovedValue) isNil.
	self assert: (window instVarNamed: #lastIndex) isNil.
	subject collection remove: 20.
	self assert: window lastRemovedValue equals: 20.
	self assert: window lastIndex equals: 4.
	subject collection remove: 13.
	self assert: window lastRemovedValue equals: 13.
	self assert: window lastIndex equals: 3.
	subject collection remove: 31.
	self assert: window lastRemovedValue equals: 31.
	self assert: window lastIndex equals: 3.

]

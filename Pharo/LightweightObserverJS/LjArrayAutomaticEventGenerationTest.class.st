Class {
	#name : #LjArrayAutomaticEventGenerationTest,
	#superclass : #LjAutomaticEventGenerationTest,
	#category : #'LightweightObserverJS-Tests'
}

{ #category : #testing }
LjArrayAutomaticEventGenerationTest >> testAtPut [
	self evalBlock: [
		subject collection: { 11. 21. 31. }.
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

{ #category : #testing }
LjArrayAutomaticEventGenerationTest >> testReset [
	self evalBlock: [
		subject collection: #(a b).
		subject 
			afterReplaceInCollection: #collection 
			do: [ : index : addedValue : removedValue| 
				window instVarNamed: #lastIndex put: index.
				window instVarNamed: #lastRemovedValue put: removedValue.
				window instVarNamed: #lastAddedValue put: addedValue].
			subject collection: { 11. 21. 31. }.
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

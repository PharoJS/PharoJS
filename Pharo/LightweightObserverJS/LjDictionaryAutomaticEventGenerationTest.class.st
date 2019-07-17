Class {
	#name : #LjDictionaryAutomaticEventGenerationTest,
	#superclass : #LjAutomaticEventGenerationTest,
	#category : #'LightweightObserverJS-Tests'
}

{ #category : #testing }
LjDictionaryAutomaticEventGenerationTest >> testAtIfAbsentPut [
	self evalBlock: [
	subject collection: Dictionary new.
		subject 
			afterReplaceInCollection: #collection 
			do: [ : key : addedValue : removedValue| 
				window instVarNamed: #modifiedKey put: key.
				window instVarNamed: #lastRemovedValue put: removedValue.
				window instVarNamed: #lastAddedValue put: addedValue]
	].
	self evalBlock: [subject collection at: #a ifAbsentPut: [10]].
	self assert: (window instVarNamed: #lastRemovedValue) equals: nil.
	self assert: window lastAddedValue equals: 10.
	self assert: window modifiedKey equals: #a.
	self evalBlock: [subject collection at: #b ifAbsentPut: [20]].
	self assert: (window instVarNamed: #lastRemovedValue) equals: nil.
	self assert: window lastAddedValue equals: 20.
	self assert: window modifiedKey equals: #b.
	self evalBlock: [subject collection at: #a ifAbsentPut: [33]].
	self assert: (window instVarNamed: #lastRemovedValue) equals: nil.
	self assert: window lastAddedValue equals: 20.
	self assert: window modifiedKey equals: #b.

]

{ #category : #testing }
LjDictionaryAutomaticEventGenerationTest >> testAtPut [
	self evalBlock: [
		subject collection: Dictionary new.
		subject collection
			at: #a put: 11;
			at: #b put: 21;
			at: #c put: 31.
		subject 
			afterReplaceInCollection: #collection 
			do: [ : key : addedValue : removedValue| 
				window instVarNamed: #modifiedKey put: key.
				window instVarNamed: #lastRemovedValue put: removedValue.
				window instVarNamed: #lastAddedValue put: addedValue]
	].
	subject collection at: #a put: 10.
	self assert: window lastRemovedValue equals: 11.
	self assert: window lastAddedValue equals: 10.
	self assert: window modifiedKey equals: #a.
	subject collection at: #b put: 20.
	self assert: window lastRemovedValue equals: 21.
	self assert: window lastAddedValue equals: 20.
	self assert: window modifiedKey equals: #b.
	
]

{ #category : #testing }
LjDictionaryAutomaticEventGenerationTest >> testReset [
	subject collection: { #z->''. #x->'x men'. #s->'spider man'. } asDictionary.
		self evalBlock: [
		subject collection: Dictionary new.
		subject collection
			at: #z put: 'zorro';
			at: #x put: 'x men';
			at: #s put: 'spider man'.
		subject 
			afterReplaceInCollection: #collection 
			do: [ : key : addedValue : removedValue| 
				window instVarNamed: #modifiedKey put: key.
				window instVarNamed: #lastRemovedValue put: removedValue.
				window instVarNamed: #lastAddedValue put: addedValue].
		subject collection: Dictionary new.
		subject collection
			at: #a put: 11;
			at: #b put: 21;
			at: #c put: 31.
	].
	subject collection at: #a put: 10.
	self assert: window lastRemovedValue equals: 11.
	self assert: window lastAddedValue equals: 10.
	self assert: window modifiedKey equals: #a.
	subject collection at: #b put: 20.
	self assert: window lastRemovedValue equals: 21.
	self assert: window lastAddedValue equals: 20.
	self assert: window modifiedKey equals: #b.
	
]

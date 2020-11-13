Class {
	#name : #PhxPharoJsonSerialisationTests,
	#superclass : #TestCase,
	#category : #PharoJsSerializationTest
}

{ #category : #tests }
PhxPharoJsonSerialisationTests >> testArraysCircularReferences [
	| cClone aClone bClone a b c |
	a := {'A'. nil. nil. nil}.
	b := {'B'. nil. nil. nil }.
	c := {'C'. nil. nil. nil }.
	{ a. b. c } do: [ : each |
		each at: 2 put: a.
		each at: 3 put: b.
		each at: 4 put: c.
	].
	cClone := PhxJsonReader readFromString: c asPhxJsonString.
	aClone := cClone second.
	bClone := cClone third.
	{ aClone. bClone. cClone.}  with: #(A B C) do: [ : each : name |
		self assert: each size equals: 4.
		self assert: each first equals: name.
		self assert: each second identicalTo: aClone.
		self assert: each third identicalTo: bClone.
		self assert: each last identicalTo: cClone.
	].
]

{ #category : #tests }
PhxPharoJsonSerialisationTests >> testDictionariesReferencingEachOther [
	| cClone bClone aInBClone aInCClone  a b c |
	a := Dictionary new.
	a at: #name put: 'A'.
	b := Dictionary new.
	b at: #name put: 'B'.
	b at: #a put: a.
	c := Dictionary new.
	c at: #name put: 'C'.
	c at: #a put: a.
	c at: #b put: b.
	cClone := PhxJsonReader readFromString: c asPhxJsonString.
	self assert: cClone size equals: 3.
	self assert: (cClone at: #name) equals: 'C'.
	aInCClone := cClone at: #a.
	self deny: aInCClone isNil.
	self assert: aInCClone size equals: 1.
	self assert: (aInCClone at: #name) equals: 'A'.
	bClone := cClone at: #b.
	self deny: bClone isNil.
	self assert: bClone size equals: 2.
	self assert: (bClone at: #name) equals: 'B'.
	aInBClone := bClone at: #a.
	self assert: aInBClone identicalTo: aInCClone.

]

{ #category : #tests }
PhxPharoJsonSerialisationTests >> testDictionariesWithCircularReferences [
	| cClone aClone bClone  a b c |
	a := Dictionary new.
	a at: #name put: 'A'.
	b := Dictionary new.
	b at: #name put: 'B'.
	c := Dictionary new.
	c at: #name put: 'C'.
	{ a. b. c } do: [ : each |
		each at: #a put: a.
		each at: #b put: b.
		each at: #c put: c.
	].
	cClone := PhxJsonReader readFromString: c asPhxJsonString.
	aClone := cClone at: #a.
	bClone := cClone at: #b.
	{ aClone. bClone. cClone.}  with: #(A B C) do: [ : each : name |
		self assert: each size equals: 4.
		self assert: (each at: #name) equals: name.
		self assert: (each at: #a) identicalTo: aClone.
		self assert: (each at: #b) identicalTo: bClone.
		self assert: (each at: #c) identicalTo: cClone.
	].
]

{ #category : #tests }
PhxPharoJsonSerialisationTests >> testOrderedCollectionsCircularReferences [
	| cClone aClone bClone a b c |
	a := #('A') asOrderedCollection.
	b := #('B') asOrderedCollection.
	c := #('C') asOrderedCollection.
	{ a. b. c } do: [ : each |
		each add: a.
		each add: b.
		each add: c.
	].
	cClone := PhxJsonReader readFromString: c asPhxJsonString.
	aClone := cClone second.
	bClone := cClone third.
	{ aClone. bClone. cClone.}  with: #(A B C) do: [ : each : name |
		self assert: each size equals: 4.
		self assert: each first equals: name.
		self assert: each second identicalTo: aClone.
		self assert: each third identicalTo: bClone.
		self assert: each last identicalTo: cClone.
	].
]

{ #category : #tests }
PhxPharoJsonSerialisationTests >> testProperInstRefOrderWhenUsingCollections [
	| obj problemObject string |
	obj := Object new.
	problemObject := {obj.
	{obj}}.
	string := problemObject asPhxJsonString.
	self shouldnt: [ PhxJsonReader readFromString: string ] raise: Error
]

{ #category : #tests }
PhxPharoJsonSerialisationTests >> testSetsCircularReferences [
	<expectedFailure>
	| cClone aClone bClone  a b c |
	self fail: 'Pharo bug: Infinite recursion upon adding cross set references'.
	a := #('A') asSet.
	b := {'B'} asSet.
	c := {'C'} asSet.
	{ a. b. c } do: [ : each |
		each add: a.
		each add: b.
		each add: c.
	].
	cClone := PhxJsonReader readFromString: c asPhxJsonString.
	aClone := cClone detect: [: each | each includes: 'A'].
	bClone := cClone detect: [: each | each includes: 'B'].
	{ aClone. bClone. cClone.} with: #(A B C) do: [ : each : name |
		self assert: each size equals: 4.
		self assert: (each includes: name).
		{ aClone. bClone. cClone.} do: [ : expectedElement |
			self assert: (each includes: expectedElement) ]
	].
]

{ #category : #tests }
PhxPharoJsonSerialisationTests >> testSetsReferencingEachOther [
	| cClone bClone a b c aInBClone aInCClone |
	a := #('A') asSet.
	b := { 'B'. a } asSet.
	c := { 'C'. a. b } asSet.
	cClone := PhxJsonReader readFromString: c asPhxJsonString.
	self assert: cClone size equals: 3.
	self assert: (cClone includes: 'C').
	self deny: (cClone includes: cClone).
	bClone := cClone detect: [ : each | each size = 2 ].
	self assert: (bClone includes: 'B').
	self deny: (bClone includes: bClone).
	aInBClone := bClone detect: [ : each | each size = 1 ].
	self assert: aInBClone size equals: 1.
	self assert: (aInBClone includes: 'A').
	aInCClone := cClone detect: [ : each | each size = 1 ].
	self assert: aInBClone identicalTo: aInCClone.
]

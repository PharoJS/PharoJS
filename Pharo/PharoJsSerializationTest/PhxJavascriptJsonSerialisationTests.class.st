Class {
	#name : #PhxJavascriptJsonSerialisationTests,
	#superclass : #PjBridgeTestCase,
	#category : #PharoJsSerializationTest
}

{ #category : #tests }
PhxJavascriptJsonSerialisationTests >> testArraysCircularReferences [
	| cClone aClone bClone |
	cClone := self evalBlock: [
		| a b c |
		a := #('A' nil nil nil).
		b := {'B'. nil. nil. nil }.
		c := {'C'. nil. nil. nil }.
		{ a. b. c } do: [ : each |
			each at: 2 put: a.
			each at: 3 put: b.
			each at: 4 put: c.
		].
		PhxJsonReader readFromString: c asPhxJsonString.
		].	
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
PhxJavascriptJsonSerialisationTests >> testDictionariesWithCircularReferences [
	| cClone aClone bClone |
	cClone := self evalBlock: [
		| a b c |
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
		PhxJsonReader readFromString: c asPhxJsonString.
		].
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
PhxJavascriptJsonSerialisationTests >> testOrderedCollectionsCircularReferences [
	| cClone aClone bClone |
	cClone := self evalBlock: [
		| a b c |
		a := #('A') asOrderedCollection.
		b := {'B'} asOrderedCollection.
		c := {'C'} asOrderedCollection.
		{ a. b. c } do: [ : each |
			each add: a.
			each add: b.
			each add: c.
		].
		PhxJsonReader readFromString: c asPhxJsonString.
		].	
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
PhxJavascriptJsonSerialisationTests >> testSetsCircularReferences [
	| cClone aClone bClone |
	cClone := self evalBlock: [
		| a b c |
		a := #('A') asSet.
		b := {'B'} asSet.
		c := {'C'} asSet.
		{ a. b. c } do: [ : each |
			each add: a.
			each add: b.
			each add: c.
		].
		PhxJsonReader readFromString: c asPhxJsonString.
		].	
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
PhxJavascriptJsonSerialisationTests >> testSetsReferencingEachOther [
	| cClone bClone |
	cClone := self evalBlock: [
		| a b c |
		a := #() asSet.
		b := { a } asSet.
		c := { a. b } asSet.
		PhxJsonReader readFromString: c asPhxJsonString.
	].
	self assert: cClone size equals: 2.
	self deny: (cClone includes: cClone).
	bClone := cClone detect: [ : each | each size = 1 ].
	self deny: (bClone includes: bClone).
	self deny: (bClone includes: cClone).
	
]

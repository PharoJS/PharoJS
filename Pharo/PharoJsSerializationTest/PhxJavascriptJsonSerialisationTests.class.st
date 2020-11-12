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
PhxJavascriptJsonSerialisationTests >> testDictionariesReferencingEachOther [
	| cClone aClone bClone |
	cClone := self evalBlock: [
		| a b c |
		a := Dictionary new.
		a at: #name put: 'A'.
		b := Dictionary new.
		b at: #name put: 'B'.
		b at: #a put: a.
		c := Dictionary new.
		c at: #name put: 'C'.
		c at: #a put: a.
		c at: #b put: b.
		PhxJsonReader readFromString: c asPhxJsonString.
		].
	self assert: cClone size equals: 3.
	aClone := cClone at: #a.
	self assert: aClone size equals: 1.
	self assert: (aClone at: #name) equals: 'A'.
	bClone := cClone at: #b.
	self assert: bClone size equals: 2.
	self assert: (bClone at: #name) equals: 'B'.
	self assert: (bClone at: #b) identicalTo: aClone.

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
	| cClone aClone bClone identitySet |
	cClone := self evalBlock: [
		| a b c |
		a := {'A'} asSet.
		b := {'B'} asSet.
		c := {'C'} asSet.
		{a. b. c} do: [ : each | each addAll: {a. b. c} ].
		PhxJsonReader readFromString: c asPhxJsonString.
		].	
	aClone := cClone detect: [: each | each includes: 'A'] ifNone: [nil].
	bClone := cClone detect: [: each | each includes: 'B'] ifNone: [nil].
	{ aClone. bClone. cClone.} with: #(A B C) do: [ : each : name |
		self assert: each size equals: 4.
		self assert: (each includes: name).
	].
	identitySet := IdentitySet new.
	{aClone. bClone. cClone} do: [ : each | identitySet addAll: each ].
	identitySet removeAll: #(A B C).
	self assert: identitySet size equals: 3.
	
]

{ #category : #tests }
PhxJavascriptJsonSerialisationTests >> testSetsReferencingEachOther [
	| cClone bClone aInBClone aInCClone |
	cClone := self evalBlock: [
		| a b c |
		a := #('A') asSet.
		b := {'B'. a } asSet.
		c := {'C'. a. b } asSet.
		PhxJsonReader readFromString: c asPhxJsonString.
	].
	self assert: cClone size equals: 3.
	self assert: (cClone includes: 'C').
	self deny: (cClone includes: cClone).
	bClone := cClone detect: [ : each | each includes: 'B' ] ifNone: [nil].
	self assert: bClone size equals: 2.
	self deny: (bClone includes: bClone).
	aInBClone := bClone detect: [ : each | each includes: 'A' ] ifNone: [nil].
	self assert: aInBClone size equals: 1.
	aInCClone := cClone detect: [ : each | each includes: 'A' ] ifNone: [nil].
	self assert: aInBClone identicalTo: aInCClone.
]

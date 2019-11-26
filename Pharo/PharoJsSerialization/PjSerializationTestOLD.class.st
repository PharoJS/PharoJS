Class {
	#name : #PjSerializationTestOLD,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsSerialization-Tests'
}

{ #category : #testing }
PjSerializationTestOLD >> testCircularReferences [
	self assertBlock: [ 
		|c1 c2 s|
		s := Set new.
		c1 := PjCompositeForSerializationTest new.
		c2 := PjCompositeForSerializationTest new.
		c1 a: c2.
		c1 b: s.
		c2 a: s.
		c2 b: c1.
		s add: c1; add: c2.
		PjSerializationTestSupport assertComplexObject: s.
		PjSerializationTestSupport assertComplexObject: c1.
		PjSerializationTestSupport assertComplexObject: c2.
	].

]

{ #category : #testing }
PjSerializationTestOLD >> testCollectionsOfBasicTypes [
	self assert: [ #() serialize ] evaluatesTo: '[["Array",[]]]'.
	self assertBlock: [ PjSerializationTestSupport assertCollection: #() ].
	self assert: [ #(1 2 3) serialize ] evaluatesTo: '[["Array",[2,3,4]],["Number",1],["Number",2],["Number",3]]'.
	self assertBlock: [ PjSerializationTestSupport assertCollection: #(1 2 3) ].
true ifTrue: [ ^self ].
	self assertBlock: [ PjSerializationTestSupport assertCollection: #(30 20 10) ].
	self assertBlock: [ PjSerializationTestSupport assertCollection: #('abc' 'other' 'yes') ].
	self assertBlock: [ PjSerializationTestSupport assertCollection: OrderedCollection new ].
	self assertBlock: [ PjSerializationTestSupport assertCollection: Set new ].
	self assertBlock: [ 
		|s|
		s := Set new.
		s addAll: #(1 2 3).
		PjSerializationTestSupport assertCollection: s ].
	self assertBlock: [ PjSerializationTestSupport assertCollection: SortedCollection new ].
	self assertBlock: [ 
		|s|
		s := SortedCollection new.
		s addAll: #(310 22 13).
		PjSerializationTestSupport assertCollection: s ].

]

{ #category : #testing }
PjSerializationTestOLD >> testCollectionsOfComplexTypes [
	self assertBlock: [ 
		|s|
		s := Set new.
		s addAll: {Time now. 1 hour}.
		PjSerializationTestSupport assertCollection: s ].
	self assertBlock: [ 
		|c1 c2 s|
		s := Set new.
		s addAll: {'wonderful'. 'world'}.
		c1 := PjCompositeForSerializationTest new.
		c1 a: 456.
		c1 b: true.
		c2 := PjCompositeForSerializationTest new.
		c2 a: s.
		c2 b: c1.
		PjSerializationTestSupport assertComplexObject: c2.
		].

]

{ #category : #testing }
PjSerializationTestOLD >> testCollectionsWithCircularReferences [
	self fail: #todo.

]

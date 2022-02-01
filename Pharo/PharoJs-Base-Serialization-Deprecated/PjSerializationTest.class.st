Class {
	#name : #PjSerializationTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Serialization-Deprecated-Tests'
}

{ #category : #testing }
PjSerializationTest >> testBasicTypes [
	self assert: [ 'abc' serialize ] evaluatesTo: '["String","abc"]'.
	self assert: [ 3.14 serialize ] evaluatesTo: '["Number",3.14]'.
	self assert: [ true serialize ] evaluatesTo: '["Boolean",true]'.
	self assert: [ nil serialize ] evaluatesTo: '["PjUndefinedObject",{}]'.
	self assertBlock: [ PjSerializationTestSupport assertEquals: 645].
	self assertBlock: [ PjSerializationTestSupport assertEquals: 3.14].
	self assertBlock: [ PjSerializationTestSupport assertEquals: 'hello' ].
	self assertBlock: [ PjSerializationTestSupport assertIdentity: nil ].
	self assertBlock: [ PjSerializationTestSupport assertIdentity: true ].
	self assertBlock: [ PjSerializationTestSupport assertIdentity: false ].
]

{ #category : #testing }
PjSerializationTest >> testCollectionsOfBasicTypes [
	self assertBlock: [ PjSerializationTestSupport assertCollection: #() ].
	self assertBlock: [ PjSerializationTestSupport assertCollection: #(1 2 3) ].
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
PjSerializationTest >> testCollectionsOfComplexTypes [
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
PjSerializationTest >> testDuration [
	self assertBlock: [ PjSerializationTestSupport assertDuration: Duration zero].
	self assertBlock: [ PjSerializationTestSupport assertDuration: 10 years].
	self assertBlock: [ PjSerializationTestSupport assertDuration: 6 months].
	self assertBlock: [ PjSerializationTestSupport assertDuration: 2 weeks].
	self assertBlock: [ PjSerializationTestSupport assertDuration: 2 hours].
	self assertBlock: [ PjSerializationTestSupport assertDuration: 30 minutes].
	self assertBlock: [ PjSerializationTestSupport assertDuration: 10 seconds].
]

{ #category : #testing }
PjSerializationTest >> testTime [
	self assertBlock: [ PjSerializationTestSupport assertTime: Time now].
	self assertBlock: [ 
		PjSerializationTestSupport assertTime: (Time hour: 1 minute: 1 second: 13)].
	self assertBlock: [ 
		PjSerializationTestSupport assertTime: (Time now seconds: 25)].
	self assertBlock: [ 
		PjSerializationTestSupport assertTime: (Time now seconds: 625)].
	self assertBlock: [ 
		PjSerializationTestSupport assertTime: (Time noon)].
	self assertBlock: [ 
		PjSerializationTestSupport assertTime: (Time midnight)].
	self assertBlock: [ 
		PjSerializationTestSupport assertTime: (Time hour: 1 minute: 0 second: 0)].
	self assertBlock: [ 
		PjSerializationTestSupport assertTime: (Time hour: 12 minute: 0 second: 0)].
	self assertBlock: [ 
		PjSerializationTestSupport assertTime: (Time hour: 13 minute: 0 second: 0)].
	self assertBlock: [ 
		PjSerializationTestSupport assertTime: (Time hour: 23 minute: 59 second: 30)].
]

{ #category : #testing }
PjSerializationTest >> testTimeDetailledSerialization [
	| now clone |
	now := self evalBlock: [ 
				window instVarNamed: #now put: Time now.
		 		window now.
	].
	clone := self evalBlock: [ PjSerializationTestSupport serializeThenMaterialize: window now].
	self assert: clone hour24 equals: now hour24.
	self assert: clone minute equals: now minute.
	self assert: clone second equals: now second.
]

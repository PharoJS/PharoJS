Class {
	#name : #PjDictionaryTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsCoreLibrariesTest-Collections'
}

{ #category : #testing }
PjDictionaryTest >> testAsDictionary [
	| original asDictResult |
	original := self bridge evalBlock: [ Dictionary new].
	original 
		at: #a put: 1;
		at: #b put: 2.
	asDictResult := original asDictionary.
	self assert: original == asDictResult
]

{ #category : #testing }
PjDictionaryTest >> testAtIfAbsent [
	self assertEquivalent: [|d|
		d := Dictionary new.
		d at: #x ifAbsent: [42]].

]

{ #category : #testing }
PjDictionaryTest >> testAtIfAbsentPut [
	self assertEquivalent: [|d|
		d := Dictionary new.
		d at: #x ifAbsentPut: 42.
		d at: #x].

]

{ #category : #testing }
PjDictionaryTest >> testAtIfEmpty [
	self assertEquivalent: [ Dictionary new isEmpty ].
	self assertEquivalent: [ (Dictionary new at: #x put: 4;yourself) isEmpty ].
	self assertEquivalent: [|d|
		d := Dictionary new.
		d ifEmpty: [ 3 ]].
	self assertEquivalent: [|d|
		d := Dictionary new.
		d ifEmpty: [ 3 ] ifNotEmpty: [42]].
	self assertEquivalent: [|d|
		d := Dictionary new.
		d ifNotEmpty: [ 3 ] ifEmpty: [42]].
	self assertEquivalent: [|d t|
		d := Dictionary new.t:=5.
		d at: #x put: 4.
		d ifEmpty: [ t:=3 ].t].
	self assertEquivalent: [|d|
		d := Dictionary new.
		d at: #x put: 4.
		d ifEmpty: [ 3 ] ifNotEmpty: [42]].
	self assertEquivalent: [|d|
		d := Dictionary new.
		d at: #x put: 4.
		d ifNotEmpty: [ 3 ] ifEmpty: [42]].

]

{ #category : #testing }
PjDictionaryTest >> testAtPut [
	self assertEquivalent: [|d|
		d := Dictionary new.
		d at: #x put: 42.
		d at: #x].
	self assert: [|d|
		d := Dictionary new.
		d at: #x put: 42.
		d] evaluatesToRaw: '{"x":42}'
]

{ #category : #testing }
PjDictionaryTest >> testBridgeConstructor [
	| eg |
	eg := self bridge
		evalBlock: [ {(#a -> 3).
			(#b -> 5)} asDictionary ].
	self assert: [ eg at: #a ] evaluatesTo: 3.
	self assert: [ eg at: #b ] evaluatesTo: 5.
	self
		assert: [ eg
				add: #c -> 42;
				at: #c ]
		evaluatesTo: 42.
	self assert: [ eg keys ] evaluatesToRaw: '["a","b","c"]'
]

{ #category : #testing }
PjDictionaryTest >> testBridgeConstructorSimple [
	| eg |
	eg := self bridge evalBlock: [ {(#a -> 3)} asDictionary ].
	self assert: [ eg at: #a ] evaluatesTo: 3.
	self assert: [ eg keys ] evaluatesToRaw: '["a"]'
]

{ #category : #testing }
PjDictionaryTest >> testDictionaryWithProxies [
	| proxy dictionaryWithProxy |
	proxy := self evalBlock: [ Object new ].
	dictionaryWithProxy := { #someId -> proxy } asDictionary.
	self 
		shouldnt: [window instVarNamed: #dict put:  dictionaryWithProxy ]
		raise: Error
]

{ #category : #testing }
PjDictionaryTest >> testKeysAndValuesDo [
	| eg |
	eg := self bridge
		evalBlock: [ {(#a -> 3).
			(#b -> 5).
			(#c -> 42)} asDictionary ].
	self
		assert: [ | count |
			count := 0.
			eg keysAndValuesDo: [ :k :v | count := count + v ].
			count ]
		evaluatesTo: 50.
	self
		assert: [ | count |
			count := 0.
			eg values do: [ :v | count := count + v ].
			count ]
		evaluatesTo: 50.
	self
		assert: [ | count |
			count := 0.
			eg do: [ :v | count := count + v ].
			count ]
		evaluatesTo: 50.
	self assert: [ eg isEmpty ] evaluatesTo: false.
	self assert: [ Dictionary new isEmpty ] evaluatesTo: true
]

{ #category : #testing }
PjDictionaryTest >> testNewFromPairs [
	| d |
	d := self bridge
		evalBlock: [ Dictionary newFromPairs: #(#x 17 #y 42) ].
	self assert: d asRawJSONString equals: '{"x":17,"y":42}'
]

{ #category : #testing }
PjDictionaryTest >> testNonInterference [
	" make sure dictionary emulation doesn't interfere "
	self assert: [document body classList add: 'hello'] evaluatesTo: nil.
	self assert: [document body classList contains: 'hello'] evaluatesTo: true
]

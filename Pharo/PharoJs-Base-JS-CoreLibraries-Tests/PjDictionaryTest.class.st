Class {
	#name : 'PjDictionaryTest',
	#superclass : 'PjBridgeTestCase',
	#category : 'PharoJs-Base-JS-CoreLibraries-Tests-Collections',
	#package : 'PharoJs-Base-JS-CoreLibraries-Tests',
	#tag : 'Collections'
}

{ #category : 'tests' }
PjDictionaryTest >> testAsDictionary [
	| original asDictResult |
	original := self bridge evalBlock: [ Dictionary new].
	original 
		at: #a put: 1;
		at: #b put: 2.
	asDictResult := original asDictionary.
	self assert: original == asDictResult
]

{ #category : 'tests' }
PjDictionaryTest >> testAtIfAbsent [
	self assertEquivalent: [|d|
		d := Dictionary new.
		d at: #x ifAbsent: [42]].
]

{ #category : 'tests' }
PjDictionaryTest >> testAtIfAbsentPut [
	self assertEquivalent: [|d|
		d := Dictionary new.
		d at: #x ifAbsentPut: 42.
		d at: #x].
]

{ #category : 'tests' }
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

{ #category : 'tests' }
PjDictionaryTest >> testAtPut [
	| dict key1 value1 key2 value2 key3 value3 |
	self assert: [|d|
		d := Dictionary new.
		d at: #x put: 42.
		d] evaluatesToRaw: '{"x":42}'.
	dict := self evalBlock: [Dictionary new].
	key1 := self evalBlock: [ 1@1 ].
	value1 := 'my first point'.
	key2 := self evalBlock: [ Object ].
	value2 := 42.
	key3 := #x.
	value3 := self evalBlock: [ Object new ].
	dict at: key1 put: value1.
	dict at: key2 put: value2.
	dict at: key3 put: value3.
	self assert: (dict at: key1) equals: value1.
	self assert: (dict at: key2) equals: value2.
	self assert: (dict at: key3) equals: value3

]

{ #category : 'tests' }
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

{ #category : 'tests' }
PjDictionaryTest >> testBridgeConstructorSimple [
	| eg |
	eg := self bridge evalBlock: [ {(#a -> 3)} asDictionary ].
	self assert: [ eg at: #a ] evaluatesTo: 3.
	self assert: [ eg keys ] evaluatesToRaw: '["a"]'
]

{ #category : 'tests' }
PjDictionaryTest >> testDictionaryWithProxies [
	| proxy dictionaryWithProxy |
	proxy := self evalBlock: [ Object new ].
	dictionaryWithProxy := { #someId -> proxy } asDictionary.
	self 
		shouldnt: [window instVarNamed: #dict put:  dictionaryWithProxy ]
		raise: Error
]

{ #category : 'tests' }
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
			eg do: [ :v | count := count + v ].
			count ]
		evaluatesTo: 50.
	self assert: [ eg isEmpty ] evaluatesTo: false.
	self assert: [ Dictionary new isEmpty ] evaluatesTo: true
]

{ #category : 'tests' }
PjDictionaryTest >> testNewFromPairs [
	| d |
	d := self bridge
		evalBlock: [ Dictionary newFromPairs: #(#x 17 #y 42) ].
	self assert: d asRawJSONString equals: '{"x":17,"y":42}'
]

{ #category : 'tests' }
PjDictionaryTest >> testNonInterference [
	" make sure dictionary emulation doesn't interfere "
	self assert: [document body classList add: 'hello'] evaluatesTo: nil.
	self assert: [document body classList contains: 'hello'] evaluatesTo: true
]

{ #category : 'tests' }
PjDictionaryTest >> testUseEqualObjectsAsKeys [
	self assert: [
		|dict firstKey secondKey| 
		dict := Dictionary new.
		firstKey := PjObjectForDictTest data: 1.
		dict at: firstKey put: 'A'.
		secondKey := PjObjectForDictTest data: 1.
		dict at: secondKey put: 'B'.
		dict at: firstKey
	] evaluatesTo: 'B'.
]

{ #category : 'tests' }
PjDictionaryTest >> testUseNonEqualObjectsAsKeys [
	self assert: [
		|dict firstKey secondKey| 
		dict := Dictionary new.
		firstKey := PjObjectForDictTest data: 1.
		dict at: firstKey put: 'A'.
		secondKey := PjObjectForDictTest data: 2.
		dict at: secondKey put: 'B'.
		dict at: firstKey
	] evaluatesTo: 'A'.
]

{ #category : 'tests' }
PjDictionaryTest >> testValues [
	| dict  |
	dict := self bridge evalBlock: [ Dictionary new ].
	dict
		at: #a put: 1;
		at: #b put: 2.
	self assertCollection: dict values asLocalObject equals: #(1 2)
]

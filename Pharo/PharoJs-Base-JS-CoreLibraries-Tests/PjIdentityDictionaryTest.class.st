Class {
	#name : #PjIdentityDictionaryTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #tests }
PjIdentityDictionaryTest >> testAsDictionary [
	| original asDictResult |
	original := self bridge evalBlock: [ IdentityDictionary new].
	original 
		at: #a put: 1;
		at: #b put: 2.
	asDictResult := original asDictionary.
	self assert: original == asDictResult
]

{ #category : #tests }
PjIdentityDictionaryTest >> testAtIfAbsent [
	self assertEquivalent: [|d|
		d := IdentityDictionary new.
		d at: #x ifAbsent: [42]].
]

{ #category : #tests }
PjIdentityDictionaryTest >> testAtIfAbsentPut [
	self assertEquivalent: [|d|
		d := IdentityDictionary new.
		d at: #x ifAbsentPut: 42.
		d at: #x].
	self assertEquivalent: [|d|
		d := IdentityDictionary new.
		d at: #x ifAbsentPut: [42].
		d at: #x].
]

{ #category : #tests }
PjIdentityDictionaryTest >> testAtIfEmpty [
	self assertEquivalent: [ IdentityDictionary new isEmpty ].
	self assertEquivalent: [ (IdentityDictionary new at: #x put: 4;yourself) isEmpty ].
	self assertEquivalent: [|d|
		d := IdentityDictionary new.
		d ifEmpty: [ 3 ]].
	self assertEquivalent: [|d|
		d := IdentityDictionary new.
		d ifEmpty: [ 3 ] ifNotEmpty: [42]].
	self assertEquivalent: [|d|
		d := IdentityDictionary new.
		d ifNotEmpty: [ 3 ] ifEmpty: [42]].
	self assertEquivalent: [|d t|
		d := IdentityDictionary new.t:=5.
		d at: #x put: 4.
		d ifEmpty: [ t:=3 ].t].
	self assertEquivalent: [|d|
		d := IdentityDictionary new.
		d at: #x put: 4.
		d ifEmpty: [ 3 ] ifNotEmpty: [42]].
	self assertEquivalent: [|d|
		d := IdentityDictionary new.
		d at: #x put: 4.
		d ifNotEmpty: [ 3 ] ifEmpty: [42]].
]

{ #category : #tests }
PjIdentityDictionaryTest >> testAtPut [
	self assertEquivalent: [|d|
		d := IdentityDictionary new.
		d at: #x put: 42.
		d at: #x].
	self assertEquivalent: [|d|
		d := IdentityDictionary new.
		d at: #x put: 42.
		d size]
]

{ #category : #tests }
PjIdentityDictionaryTest >> testKeysAndValuesDo [
	| dict |
	dict := self bridge
		evalBlock: [ 
			IdentityDictionary new
				at: #a put: 3;
				at: #b put: 5;
				at: #c put: 42;
				yourself ].
	self
		assert: [ | count |
			count := 0.
			dict keysAndValuesDo: [ :k :v | count := count + v ].
			count ]
		evaluatesTo: 50.
	self
		assert: [ | count |
			count := 0.
			dict do: [ :v | count := count + v ].
			count ]
		evaluatesTo: 50.
	self assert: [ dict isEmpty ] evaluatesTo: false.
	self assert: [ IdentityDictionary new isEmpty ] evaluatesTo: true
]

{ #category : #tests }
PjIdentityDictionaryTest >> testNewFromPairs [
	| d |
	d := self bridge
		evalBlock: [ IdentityDictionary newFromPairs: #(#x 17 #y 42) ].
]

{ #category : #tests }
PjIdentityDictionaryTest >> testNonInterference [
	" make sure dictionary emulation doesn't interfere "
	self assert: [document body classList add: 'hello'] evaluatesTo: nil.
	self assert: [document body classList contains: 'hello'] evaluatesTo: true
]

{ #category : #tests }
PjIdentityDictionaryTest >> testUseObjectsAsKeysForIdentityDictionary [
	self assert: [
		|dict firstKey secondKey| 
		dict := IdentityDictionary new.
		firstKey :=  PjObjectForDictTest data: 1.
		dict at: firstKey put: 'A'.
		secondKey := PjObjectForDictTest data: 1.
		dict at: secondKey put: 'B'.
		dict at: firstKey
	] evaluatesTo: 'A'.
]

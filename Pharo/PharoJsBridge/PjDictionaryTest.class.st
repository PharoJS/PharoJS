Class {
	#name : #PjDictionaryTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsBridge-Tests'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
PjDictionaryTest >> testBridgeConstructor [
	| eg |
	eg := bridge evalBlock: [{#a -> 3 . #b -> 5 } asDictionary].
	self assert: [eg at: #a] evaluatesTo: 3.
	self assert: [eg at: #b] evaluatesTo: 5.
	self assert: [eg add: (#c -> 42);at: #c] evaluatesTo: 42.
	self assert: [eg keys] evaluatesToRaw: '["a","b","c"]'
]

{ #category : #'as yet unclassified' }
PjDictionaryTest >> testBridgeConstructorSimple [
	| eg |
	eg := bridge evalBlock: [{#a -> 3 } asDictionary].
	self assert: [eg at: #a] evaluatesTo: 3.
	self assert: [eg keys] evaluatesToRaw: '["a"]'
]

{ #category : #'as yet unclassified' }
PjDictionaryTest >> testKeysAndValuesDo [
	| eg |
	eg := bridge evalBlock: [{#a -> 3 . #b -> 5 . #c -> 42 } asDictionary].
	self assert: [|count| count := 0.eg keysAndValuesDo: [: k : v | count := count + v].count] evaluatesTo: 50.
	self assert: [|count| count := 0.eg do: [: v | count := count + v].count] evaluatesTo: 50.
	self assert: [eg isEmpty] evaluatesTo: false.
	self assert: [Dictionary new isEmpty] evaluatesTo: true.

]

{ #category : #'as yet unclassified' }
PjDictionaryTest >> testNewFromPairs [
	| d |
	d := bridge evalBlock: [Dictionary newFromPairs: #(x 17 y 42)].
	self assert: d asRawJSONString equals: '{"x":17,"y":42}'
]

{ #category : #'as yet unclassified' }
PjDictionaryTest >> testNonInterference [
	" make sure dictionary emulation doesn't interfere "
	self assert: [document body classList add: 'hello'] evaluatesTo: nil.
	self assert: [document body classList contains: 'hello'] evaluatesTo: true
]

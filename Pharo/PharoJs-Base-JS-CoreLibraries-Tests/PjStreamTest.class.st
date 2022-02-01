"
I contain test for the simplistic Read/Write Stream implementation
"
Class {
	#name : #PjStreamTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #tests }
PjStreamTest >> testArrayRead [
	self assertEquivalent: [#(1 2 3) readStream next].
	self assertEquivalent: [#(1 2 3) readStream next;next].
	self assertEquivalent: [#(1 2 3) readStream next;next;next].
	self assertEquivalent: [#(1 2 3) readStream next;next;next;next].
	self assertEquivalent: [#(1 2 3) readStream next;next;next;atEnd].
]

{ #category : #tests }
PjStreamTest >> testArrayReadWrite [
	self assert: [#() writeStream nextPutAll: #(1 2 3);nextPutAll: #(4 5 6);next;next;next;next] evaluatesTo: 4.
]

{ #category : #tests }
PjStreamTest >> testArrayWrite [
	self assertEquivalent: [#(() writeStream nextPut: 3;nextPutAll: 'abc';contents) at: 2].
]

{ #category : #tests }
PjStreamTest >> testStringPeek [
	self assertEquivalent: ['abc' readStream peek asString].
	self assertEquivalent: [('abc' readStream peek;next) asString].
	self assertEquivalent: [('abc' readStream next;peek;next) asString].
	self assertEquivalent: ['abc' readStream next;next;peek;atEnd].
]

{ #category : #tests }
PjStreamTest >> testStringRead [
	self assertEquivalent: ['abc' readStream next asString].
	self assertEquivalent: [('abc' readStream next;next) asString].
	self assertEquivalent: [('abc' readStream next;next;next) asString].
	self assertEquivalent: ['abc' readStream next;next;next;atEnd].
	self assertEquivalent: ['abc' readStream next;next;next;next].
]

{ #category : #tests }
PjStreamTest >> testStringReadWrite [
	self assert: [('' writeStream nextPutAll: 'abc';nextPutAll: 'def';next;next;next;next) asString] evaluatesTo: 'd'.
]

{ #category : #tests }
PjStreamTest >> testStringWrite [
	self assertEquivalent: ['' writeStream nextPut: $x;nextPutAll: 'abc';contents].
]

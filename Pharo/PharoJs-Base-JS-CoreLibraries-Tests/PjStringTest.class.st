Class {
	#name : #PjStringTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #testing }
PjStringTest >> testConversion [
	self assertEquivalent: ['the Eiffel Tower' asUppercase].
	self assertEquivalent: ['the Eiffel Tower' asLowercase].
	self assertEquivalent: ['the Eiffel Tower' capitalized].
]

{ #category : #testing }
PjStringTest >> testConversionToNumbers [
	self assertEquivalent: ['07' asInteger].
	self assertEquivalent: ['3.14' asInteger].
	self assertEquivalent: ['3.14' asNumber].
	self assertEquivalent: ['2xyz' asNumber].
	self assertEquivalent: ['1.41xyz' asNumber].
]

{ #category : #testing }
PjStringTest >> testFirst [
	self assert: ['abc' first] evaluatesTo: 'a'.
	self assert: ['CBA' first] evaluatesTo: 'C'.
]

{ #category : #testing }
PjStringTest >> testIfEmpty [
	self assertEquivalent: ['abc' ifEmpty: ['xyz']].
	self assertEquivalent: ['' ifEmpty: ['xyz']].
]

{ #category : #testing }
PjStringTest >> testIsLetter [
	| letters nonLetters |
	letters := Character allByteCharacters select: [: each | each isLetter].
	self assertBlock: [letters allSatisfy: [: char |char isLetter]].
	nonLetters := Character allByteCharacters copyWithoutAll: letters.
	self assertBlock: [nonLetters noneSatisfy: [: char |  char isLetter]].
]

{ #category : #testing }
PjStringTest >> testLast [
	self assert: ['abc' last] evaluatesTo: 'c'.
	self assert: ['CBA' last] evaluatesTo: 'A'.
]

{ #category : #tests }
PjStringTest >> testReversed [
	self
		assertEquivalent: ['abcd' reversed].
]

{ #category : #testing }
PjStringTest >> testSplit [
	| splited |
	splited := self evalBlock: ['.' split: 'a.b.c'].
	self assert: splited size equals: 3.
	#(a b c) withIndexDo: [ : expected : index | 
		self assert: (splited at: index) equals: expected]
]

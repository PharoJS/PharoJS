Class {
	#name : #PjStringTest,
	#superclass : #PjBridgeTestCase,
	#category : #PharoJsCoreLibrariesTest
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
	letters := ($a to: $z), ($A to: $Z).
	letters := letters asArray.
	self assertBlock: [letters detect: [: char |  char isLetter not] ifFound: [ false ] ifNone: [true]].
	nonLetters := (Character characterTable reject: [: char | char isLetter]) asOrderedCollection.
	nonLetters removeAll: { Character cr. Character lf. $'. $\}.
	nonLetters := nonLetters asArray.
	self assertBlock: [nonLetters detect: [: char |  char isLetter] ifFound: [ false ] ifNone: [true]].
		
]

{ #category : #testing }
PjStringTest >> testLast [
	self assert: ['abc' last] evaluatesTo: 'c'.
	self assert: ['CBA' last] evaluatesTo: 'A'.
]

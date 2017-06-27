Class {
	#name : #PjNumberTest,
	#superclass : #PjBridgeTestCase,
	#category : #PharoJsCoreLibrariesTest
}

{ #category : #testing }
PjNumberTest >> testSpecial [
	self assertEquivalent: [Float infinity ].
	self assertEquivalent: [Float infinity negated ].
	self assertEquivalent: [Float nan ].

]

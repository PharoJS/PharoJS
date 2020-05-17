Class {
	#name : #PjAssociationTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsCoreLibrariesTest-Objects'
}

{ #category : #testing }
PjAssociationTest >> testEqualityForKeys [
	self assertEquivalent: [
		| a b |
		a := 3->4.
		b := 3->6.
		a key = b key].
]

{ #category : #testing }
PjAssociationTest >> testEqualityForValues [
	self assertEquivalent: [
		| a b |
		a := 4->3.
		b := 6->3.
		a value = b value].
]

Class {
	#name : #PjAssociationTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #tests }
PjAssociationTest >> testEqualityForAssociations [
	self assertEquivalent: [(1->#hello)=(2->#hello)].
	self assertEquivalent: [(3->#hello)=(3->#hello)].
	self assertEquivalent: [(1->#hello)=(2->#goodbye)].
	self assertEquivalent: [(3->#hello)=(3->#goodbye)].
	self assertEquivalent: [
			| a | 
			a := 3->4. 
			a = a].
	self assertEquivalent: [(1->5)=(2->5)].
	self assertEquivalent: [(3->5)=(3->5)].
	self assertEquivalent: [(1->5)=(2->8)].
	self assertEquivalent: [(3->8)=(3->8)].
]

{ #category : #tests }
PjAssociationTest >> testEqualityForKeys [
	self assertEquivalent: [
		| a b |
		a := 3->4.
		b := 3->6.
		a key = b key].
	self assertEquivalent: [
		| a b |
		a := 4->1.
		b := 6->2.
		a key = b key].
]

{ #category : #tests }
PjAssociationTest >> testEqualityForValues [
	self assertEquivalent: [
		| a b |
		a := 4->3.
		b := 6->3.
		a value = b value].
	self assertEquivalent: [
		| a b |
		a := 4->1.
		b := 6->2.
		a value = b value].
]

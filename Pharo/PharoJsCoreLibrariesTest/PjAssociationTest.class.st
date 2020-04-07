Class {
	#name : #PjAssociationTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsCoreLibrariesTest-Collections'
}

{ #category : #testing }
PjAssociationTest >> testEqualityForAssociationsWithDifferentKeys [
	self assertEquivalent: [(3->#hello)=(2->#hello)].

]

{ #category : #testing }
PjAssociationTest >> testEqualityForAssociationsWithDifferentValues [
	self assertEquivalent: [(3->2)=(3->6)].

]

{ #category : #testing }
PjAssociationTest >> testEqualityForEqualAssociations [
	self assertEquivalent: [(3->#hello)=(3->#hello)].
	self assertEquivalent: [(3->4)=(3->4)].

]

{ #category : #testing }
PjAssociationTest >> testEqualityForKeys [
	self assertEquivalent: [
		| a b |
		a := 3->4.
		b := 3->6.
		a key = b key].

]

{ #category : #testing }
PjAssociationTest >> testEqualityForSameAssociation [
	self assertEquivalent: [
			| a | 
			a := 3->4. 
			a = a].

]

{ #category : #testing }
PjAssociationTest >> testEqualityForValues [
	self assertEquivalent: [
		| a b |
		a := 4->3.
		b := 6->3.
		a value = b value].

]

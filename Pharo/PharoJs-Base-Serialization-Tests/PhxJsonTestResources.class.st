Class {
	#name : #PhxJsonTestResources,
	#superclass : #Object,
	#category : #'PharoJs-Base-Serialization-Tests'
}

{ #category : #tests }
PhxJsonTestResources class >> challengingStringRequiringUnicodeAndEscapement [
	^ 'Hi <there>, I''m just a "String", and I cost only 2€. Olé!'
]

{ #category : #tests }
PhxJsonTestResources class >> challingingObjectAvoidingDateAndTime [
	| org |
	org := PhxJsonTestResources objectWithLiteralIVs.
	^ {org.
	org.
	'Hello "world"'.
	123.
	1.33.
	{org.
	org.
	self challengingStringRequiringUnicodeAndEscapement.
	123.
	1.33}}
]

{ #category : #tests }
PhxJsonTestResources class >> objectGraphWithCycleOfLength1 [

	| leaf1 leaf2 node root |
	leaf1 := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	leaf2 := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	node := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	root := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	leaf1
		aaaa: leaf1;
		bbbb: 'Test org 1';
		cccc: 'TestOrg1LegalForm1'.
	leaf2
		aaaa: 'TestOrg2';
		bbbb: leaf2;
		cccc: 'TestOrg1LegalForm2'.
	node
		aaaa: leaf1;
		bbbb: leaf2;
		cccc: node.
	root
		aaaa: leaf1;
		bbbb: node;
		cccc: leaf2.
	^ root
]

{ #category : #tests }
PhxJsonTestResources class >> objectGraphWithCycleOfLength2 [

	| leaf1 leaf2 node root |
	leaf1 := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	leaf2 := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	node := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	root := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	leaf1
		aaaa: node;
		bbbb: 'Test org 1';
		cccc: 'TestOrg1LegalForm1'.
	leaf2
		aaaa: 'TestOrg2';
		bbbb: node;
		cccc: 'TestOrg1LegalForm2'.
	node
		aaaa: leaf1;
		bbbb: leaf2;
		cccc: root.
	root
		aaaa: leaf1;
		bbbb: node;
		cccc: leaf2.
	^ root
]

{ #category : #tests }
PhxJsonTestResources class >> objectGraphWithSharedLeaves [

	| leaf1 leaf2 node1 node2 node3 root |
	leaf1 := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	leaf2 := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	node1 := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	node2 := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	node3 := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	root := PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new.
	leaf1
		aaaa: 'stuff';
		bbbb: 'Test org 1';
		cccc: 'TestOrg1LegalForm1'.
	leaf2
		aaaa: 'TestOrg2';
		bbbb: 'more stuff';
		cccc: 'TestOrg1LegalForm2'.
	node1
		aaaa: leaf1;
		bbbb: leaf2;
		cccc: 'node2'.
	node2
		aaaa: node1;
		bbbb: leaf2;
		cccc: leaf1.
	node3
		aaaa: leaf2;
		bbbb: leaf1;
		cccc: node1.
	root
		aaaa: node3;
		bbbb: node1;
		cccc: node2.
	^ root
]

{ #category : #tests }
PhxJsonTestResources class >> objectWithLiteralIVs [

	^ PhxJsonObjectForTestWithAlphabeticallyOrderedIVs new
		  aaaa: 'TestOrg1';
		  bbbb: 'Test org 1';
		  cccc: 'TestOrg1LegalForm';
		  yourself
]

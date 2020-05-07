Class {
	#name : #PhxJsonTestResources,
	#superclass : #Object,
	#category : #PharoJsSerializationTest
}

{ #category : #tests }
PhxJsonTestResources class >> challengingStringRequiringUnicodeAndEscapement [
	^ 'Hi <there>, I''m just a "String", and I cost only 2€. Olé!'
]

{ #category : #tests }
PhxJsonTestResources class >> challingingObjectAvoidingDateAndTime [
	| org |
	org := PhxJsonTestResources testOrg1.
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
PhxJsonTestResources class >> testOrg1 [
	^ PhxJsonTestOrganisation new
		code: 'TestOrg1';
		name: 'Test org 1';
		legalForm: 'TestOrg1LegalForm';
		yourself
]

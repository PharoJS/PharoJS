Class {
	#name : #PhxJsonTestOrganisation,
	#superclass : #Object,
	#instVars : [
		'code',
		'name',
		'legalForm'
	],
	#category : #PharoJsSerializationTest
}

{ #category : #accessing }
PhxJsonTestOrganisation >> code [
	^ code
]

{ #category : #accessing }
PhxJsonTestOrganisation >> code: anObject [
	code := anObject.
]

{ #category : #accessing }
PhxJsonTestOrganisation >> legalForm [
	^ legalForm
]

{ #category : #accessing }
PhxJsonTestOrganisation >> legalForm: anObject [
	legalForm := anObject
]

{ #category : #accessing }
PhxJsonTestOrganisation >> name [
	^ name
]

{ #category : #accessing }
PhxJsonTestOrganisation >> name: anObject [
	name := anObject.
]

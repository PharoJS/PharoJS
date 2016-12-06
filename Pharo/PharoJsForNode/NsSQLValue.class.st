Class {
	#name : #NsSQLValue,
	#superclass : #Object,
	#instVars : [
		'value',
		'block'
	],
	#category : #'PharoJsForNode-SQL'
}

{ #category : #'as yet unclassified' }
NsSQLValue class >> value: anObject
block: aBlock [
	^ self new value: anObject block: aBlock;
		yourself
]

{ #category : #'as yet unclassified' }
NsSQLValue >> block [
	^ block
]

{ #category : #'as yet unclassified' }
NsSQLValue >> isSQLValue [
	^ true
]

{ #category : #'as yet unclassified' }
NsSQLValue >> value [
	^ value
]

{ #category : #'as yet unclassified' }
NsSQLValue >> value: anObject
block: aBlock [
	value := anObject.
	block := aBlock
]

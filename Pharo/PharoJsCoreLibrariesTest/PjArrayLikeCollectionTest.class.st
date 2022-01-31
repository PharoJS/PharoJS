Class {
	#name : #PjArrayLikeCollectionTest,
	#superclass : #PjBridgeTestCase,
	#instVars : [
		'collection'
	],
	#category : #'PharoJsCoreLibrariesTest-Collections'
}

{ #category : #testing }
PjArrayLikeCollectionTest class >> isAbstract [
	^self == PjArrayLikeCollectionTest
]

{ #category : #testing }
PjArrayLikeCollectionTest >> defaultCollection [
	self subclassResponsibility
]

{ #category : #testing }
PjArrayLikeCollectionTest >> setUp [
	super setUp.
	collection := self defaultCollection
]

{ #category : #testing }
PjArrayLikeCollectionTest >> testAllButFirst [
	self assert: collection allButFirst size equals: collection size - 1.
]

{ #category : #testing }
PjArrayLikeCollectionTest >> testCollectionIsNotEmpty [
	self assert: collection notEmpty.
	self deny: collection isEmpty
]

{ #category : #testing }
PjArrayLikeCollectionTest >> testIndexOf [
	| index |
	index := collection indexOf: collection first.
	self assert: index equals: 1.
	self assert: (collection at: index) == collection first
]

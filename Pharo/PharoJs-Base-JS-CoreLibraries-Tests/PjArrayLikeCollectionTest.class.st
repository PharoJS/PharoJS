Class {
	#name : #PjArrayLikeCollectionTest,
	#superclass : #PjBridgeTestCase,
	#instVars : [
		'collection'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #testing }
PjArrayLikeCollectionTest class >> isAbstract [
	^self == PjArrayLikeCollectionTest
]

{ #category : #'accessing - defaults' }
PjArrayLikeCollectionTest >> defaultCollection [
	self subclassResponsibility
]

{ #category : #running }
PjArrayLikeCollectionTest >> setUp [
	super setUp.
	collection := self defaultCollection
]

{ #category : #testing }
PjArrayLikeCollectionTest >> testIndexOf [
	| index |
	index := collection indexOf: collection first.
	self assert: index equals: 1.
	self assert: (collection at: index) == collection first
]

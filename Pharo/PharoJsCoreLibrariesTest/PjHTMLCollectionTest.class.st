Class {
	#name : #PjHTMLCollectionTest,
	#superclass : #PjBridgeTestCase,
	#instVars : [
		'htmlCollection'
	],
	#category : #PharoJsCoreLibrariesTest
}

{ #category : #testing }
PjHTMLCollectionTest >> setUp [
	super setUp.
	htmlCollection := document body children
]

{ #category : #testing }
PjHTMLCollectionTest >> testCollectionIsNotEmpty [
	self assert: htmlCollection notEmpty.
	self deny: htmlCollection isEmpty
]

{ #category : #testing }
PjHTMLCollectionTest >> testIndexOf [
	| index |
	index := htmlCollection indexOf: htmlCollection first.
	self assert: index equals: 1.
	self assert: (htmlCollection at: index) == htmlCollection first
]

Class {
	#name : #PjHtmlCollectionTest,
	#superclass : #PjArrayLikeCollectionTest,
	#category : #PharoJsCoreLibrariesTest
}

{ #category : #testing }
PjHtmlCollectionTest >> defaultCollection [
	^ document body children
]

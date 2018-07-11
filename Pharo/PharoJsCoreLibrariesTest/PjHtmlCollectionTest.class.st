Class {
	#name : #PjHtmlCollectionTest,
	#superclass : #PjArrayLikeCollectionTest,
	#category : #'PharoJsCoreLibrariesTest-Collections'
}

{ #category : #testing }
PjHtmlCollectionTest >> defaultCollection [
	^ document body children
]

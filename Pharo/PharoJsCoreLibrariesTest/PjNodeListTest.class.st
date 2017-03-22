Class {
	#name : #PjNodeListTest,
	#superclass : #PjArrayLikeCollectionTest,
	#category : #PharoJsCoreLibrariesTest
}

{ #category : #testing }
PjNodeListTest >> defaultCollection [
	^ document body childNodes
]

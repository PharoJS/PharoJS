Class {
	#name : #PjNodeListTest,
	#superclass : #PjArrayLikeCollectionTest,
	#category : #'PharoJsCoreLibrariesTest-Collections'
}

{ #category : #testing }
PjNodeListTest >> defaultCollection [
	^ document body childNodes
]

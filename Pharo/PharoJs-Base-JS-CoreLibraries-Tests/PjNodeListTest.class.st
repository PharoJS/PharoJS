Class {
	#name : #PjNodeListTest,
	#superclass : #PjArrayLikeCollectionTest,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #testing }
PjNodeListTest >> defaultCollection [
	^ document body childNodes
]

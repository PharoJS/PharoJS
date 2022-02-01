Class {
	#name : #PjHtmlCollectionTest,
	#superclass : #PjArrayLikeCollectionTest,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #testing }
PjHtmlCollectionTest >> defaultCollection [
	^ document body children
]

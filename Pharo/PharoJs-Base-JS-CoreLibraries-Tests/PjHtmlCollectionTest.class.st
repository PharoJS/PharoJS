Class {
	#name : #PjHtmlCollectionTest,
	#superclass : #PjArrayLikeCollectionTest,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #'accessing - defaults' }
PjHtmlCollectionTest >> defaultCollection [
	^ document body children
]

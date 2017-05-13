Class {
	#name : #PjSortedCollection,
	#superclass : #PjArray,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjSortedCollection class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{SortedCollection -> (SortedCollection selectors copyWithoutAll: #(collect:))}
]

{ #category : #enumerating }
PjSortedCollection >> collect: aBlock [ 
	"Evaluate aBlock with each of my elements as the argument. Collect the 
	resulting values into an OrderedCollection. Answer the new collection. 
	Override the superclass in order to produce an OrderedCollection instead
	of a SortedCollection."

	| newCollection | 
	newCollection := OrderedCollection new.
	self do: [:each | newCollection addLast: (aBlock value: each)].
	^ newCollection
]

{ #category : #'initialize-release' }
PjSortedCollection >> initialize [
	super initialize.
	self instVarNamed: #firstIndex put: 1.
	self instVarNamed: #lastIndex put: 0
]

Class {
	#name : #PjSortedCollection,
	#superclass : #PjArray,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjSortedCollection class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{SortedCollection -> SortedCollection selectors}
]

{ #category : #'initialize-release' }
PjSortedCollection >> initialize [
	super initialize.
	self instVarNamed: #firstIndex put: 1.
	self instVarNamed: #lastIndex put: 0
]

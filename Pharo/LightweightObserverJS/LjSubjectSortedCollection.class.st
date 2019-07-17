Class {
	#name : #LjSubjectSortedCollection,
	#superclass : #SortedCollection,
	#category : #'LightweightObserverJS-Kernel'
}

{ #category : #'pharoJs support' }
LjSubjectSortedCollection class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^ {LoSubjectSortedCollection->(LoSubjectSortedCollection selectors copyWithout: #remove:ifAbsent:)}
]

Class {
	#name : #LjSubjectOrderedCollection,
	#superclass : #OrderedCollection,
	#category : #'LightweightObserverJS-Kernel'
}

{ #category : #'pharoJs support' }
LjSubjectOrderedCollection class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^ {LoSubjectOrderedCollection->(LoSubjectOrderedCollection selectors copyWithout: #remove:ifAbsent:)}
]

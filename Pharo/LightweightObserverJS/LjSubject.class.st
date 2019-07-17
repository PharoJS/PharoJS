"
I am the placeholder for LoSubject.

I avoid loading all class methods dedicated to support method handling for automatic event generation.
"
Class {
	#name : #LjSubject,
	#superclass : #Object,
	#category : #'LightweightObserverJS-Kernel'
}

{ #category : #'pharoJs support' }
LjSubject class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{LoSubject -> LoSubject selectors}
]

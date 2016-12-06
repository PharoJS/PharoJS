"
I am the Javascript embodiment of Association.
"
Class {
	#name : #PjAssociation,
	#superclass : #PjLookupKey,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharojs support' }
PjAssociation class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{
		Association -> #( = key:value: value value: ).
		Association class -> #( key:value: ).
	}
]

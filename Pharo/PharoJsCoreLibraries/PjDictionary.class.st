"
I am the Javascript embodiment of Dictionary.

Note that the current implemenation uses objects, so only string keys are valid.
"
Class {
	#name : #PjDictionary,
	#superclass : #PjCollection,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharojs support' }
PjDictionary class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{Dictionary -> #(at:ifAbsentPut:).
	}

]

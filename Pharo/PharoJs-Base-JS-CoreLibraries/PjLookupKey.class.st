"
I am the Javascript embodiment of LookupKey.
"
Class {
	#name : #PjLookupKey,
	#superclass : #PjMagnitude,
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'pharojs support' }
PjLookupKey class >> javascriptName [
	<pharoJsSkip>
	^self name
]

{ #category : #'pharojs support' }
PjLookupKey class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{
		LookupKey -> #( < = key key:  ).
		LookupKey class -> #( key:  ).
	}
]

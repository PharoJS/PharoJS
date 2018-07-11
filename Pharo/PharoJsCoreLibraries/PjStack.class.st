Class {
	#name : #PjStack,
	#superclass : #Array,
	#type : #variable,
	#pools : [
		'PjUniversalGlobals'
	],
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjStack class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{Stack -> #(top pop push:)}
]

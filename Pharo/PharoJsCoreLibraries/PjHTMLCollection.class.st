"
I provide Smalltalk method to the HTMLCollection ""class"" in web browsers. Should not be included in NodeJS code.
"
Class {
	#name : #PjHTMLCollection,
	#superclass : #PjObject,
	#traits : 'PjTArray + PjTExtensionClass',
	#classTraits : 'PjTArray classTrait + PjTExtensionClass classTrait',
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjHTMLCollection class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^ {
		Collection ->#( isCollection ).
	}
]

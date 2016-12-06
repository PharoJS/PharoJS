"
I provide Smalltalk method to the NodeList ""class"" in web browsers. Should not be included in NodeJS code.
"
Class {
	#name : #PjNodeList,
	#superclass : #PjObject,
	#traits : 'PjTArray + PjTExtensionClass',
	#classTraits : 'PjTArray classTrait + PjTExtensionClass classTrait',
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjNodeList class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^ {
		Collection ->#( isCollection ).
	}
]

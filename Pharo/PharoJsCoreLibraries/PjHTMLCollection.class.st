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

{ #category : #accessing }
PjHTMLCollection >> indexOf: x [
	<javascript: 'for(var i = 0; i < this.length; i++){
		if(x == this[i]){return i + 1}
	}
	return 0;
	'>
]

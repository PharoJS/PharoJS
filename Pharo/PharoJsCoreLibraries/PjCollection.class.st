"
I am the Javascript embodiment of Collection.
"
Class {
	#name : #PjCollection,
	#superclass : #PjObject,
	#traits : 'PjTCollection',
	#classTraits : 'PjTCollection classTrait',
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharojs support' }
PjCollection class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^ self jsTranspilationImportMethodsCollection
]

{ #category : #'instance creation' }
PjCollection class >> new: ignored [
	" if this gets down to object, the numeric parameter will not do what we want "
	^ self new
]

{ #category : #testing }
PjCollection >> = aMagnitude [
	^self subclassResponsibility
]

Class {
	#name : #PjSet,
	#superclass : #PjArray,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjSet class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{Set -> #(asSet)}
]

{ #category : #enumerating }
PjSet >> addFirst: element [
	(self includes: element) ifTrue: [ ^element ].
	^super addFirst: element
	
]

{ #category : #enumerating }
PjSet >> addLast: element [
	(self includes: element) ifTrue: [ ^element ].
	^super addLast: element
	
]

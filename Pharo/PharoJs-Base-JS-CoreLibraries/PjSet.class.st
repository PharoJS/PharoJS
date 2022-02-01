"
I am the Javascript embodiment of Set.
"
Class {
	#name : #PjSet,
	#superclass : #PjArray,
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
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

{ #category : #enumerating }
PjSet >> like: anObject [
	(self includes: anObject) ifTrue: [ ^ anObject ].
	^ nil
]

{ #category : #enumerating }
PjSet >> like: anObject ifAbsent: aBlock [
	(self includes: anObject) ifTrue: [ ^ anObject ].
	^ aBlock value
]

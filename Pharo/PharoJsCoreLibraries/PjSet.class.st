Class {
	#name : #PjSet,
	#superclass : #PjArray,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'as yet unclassified' }
PjSet >> addFirst: element [
	(self includes: element) ifTrue: [ ^element ].
	^super addFirst: element
	
]

{ #category : #'as yet unclassified' }
PjSet >> addLast: element [
	(self includes: element) ifTrue: [ ^element ].
	^super addLast: element
	
]

Class {
	#name : #PjClassForDefinitionTest,
	#superclass : #Object,
	#category : #'PharoJsTranspilerTests-Support'
}

{ #category : #accessing }
PjClassForDefinitionTest class >> literal [
	<jsLiteralGenerator>
	^ 'abc','def'
]

{ #category : #accessing }
PjClassForDefinitionTest >> literal [
	<jsLiteralGenerator>
	^ 3 + 4
]

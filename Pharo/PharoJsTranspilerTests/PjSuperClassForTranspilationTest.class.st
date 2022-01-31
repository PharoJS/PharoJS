"
I am a superclass with a pool dictionary to be validated with PjTranspilerTest
"
Class {
	#name : #PjSuperClassForTranspilationTest,
	#superclass : #Object,
	#classVars : [
		'B',
		'S'
	],
	#pools : [
		'PjSharedPoolForTest'
	],
	#category : #'PharoJsTranspilerTests-Support'
}

{ #category : #'class initialization' }
PjSuperClassForTranspilationTest class >> initialize [
	B := #superB.
]

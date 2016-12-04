Class {
	#name : #PjAlternateClassForTranspilationTest,
	#superclass : #PjSuperClassForTranspilationTest,
	#classVars : [
		'A',
		'X',
		'Y',
		'prototype'
	],
	#pools : [
		'PjDomGlobals'
	],
	#category : #'PharoJsExporter-Tests-Support'
}

{ #category : #'initialization-release' }
PjAlternateClassForTranspilationTest class >> initialize [
]

{ #category : #any }
PjAlternateClassForTranspilationTest >> m [
	^ PjClassEForPackageTranspilationTest new
]

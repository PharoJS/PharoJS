"
I represent Symbols, and have the differences from PjString (which I otherwise mostly am).
"
Class {
	#name : #PjSymbol,
	#superclass : #PjString,
	#instVars : [
		'string'
	],
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjSymbol class >> jsTranspilationImportMethods [

	<pharoJsSkip>
	^ { 
		  (Symbol
		   ->
			   #( at:put: storeOn: errorNoModification ))
			}
]

{ #category : #'instance creation' }
PjSymbol class >> new [
	<javascript: 'return new PjSymbol()'>
]

{ #category : #'instance creation' }
PjSymbol class >> with: aString [

	^ self new with: aString
]

{ #category : #copying }
PjSymbol >> , other [
	^ self class with: string,other
]

{ #category : #converting }
PjSymbol >> asJsObject [

	^ self
]

{ #category : #converting }
PjSymbol >> asString [

	<jsAlias: 'toString'>
	^ string valueOf
]

{ #category : #accessing }
PjSymbol >> at: anInteger [

	^ string at: anInteger
]

{ #category : #testing }
PjSymbol >> isLiteralSymbol [
	^ true
]

{ #category : #converting }
PjSymbol >> valueOf [

	" I implement the valueOf method so that references to me as a raw string will work properly 
	  This requires changes to the exporter to remove the standard prefix and the _ to look like a standard Javascript method "

	<jsAlias: 'valueOf'>
	^ string valueOf
]

{ #category : #'instance creation' }
PjSymbol >> with: aString [
	string := aString
]

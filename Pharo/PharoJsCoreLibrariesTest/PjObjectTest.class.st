Class {
	#name : #PjObjectTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsCoreLibrariesTest-Objects'
}

{ #category : #testing }
PjObjectTest >> testNewObjectHasNoEnumeratableKeys [
	"This is important for many JS third party libraries"
	self assertBlock: [ Object new allEnumeratableKeys isEmpty ] .

]

{ #category : #testing }
PjObjectTest >> testPrintString [

	self assert: [ Object new printString ] evaluatesTo: 'an Object'.
	self assert: [ PjSet new printString ] evaluatesTo: 'a PjSet'.
	self
		assert: [ 'hello world' printString ]
		evaluatesTo: '''hello world'''.
	self
		assert: [ 'DragN''Drop' printString ]
		evaluatesTo: '''DragN''''Drop'''.
	self assert: [ 123 printString ] evaluatesTo: '123'.
	self assert: [ true printString ] evaluatesTo: 'true'.
	self assert: [ false printString ] evaluatesTo: 'false'.
	self assert: [ nil printString ] evaluatesTo: 'nil'.
	self
		assert: [ #someSymbol printString ]
		evaluatesTo: '''someSymbol'''.
	self
		assert: [ #( 1 2 3 nil true #nil #symbol ) printString ]
		evaluatesTo: '#(1 2 3 nil true ''nil'' ''symbol'')'.
	self
		assert: [ 
		#( #( 1 2 3 nil ) #(  ) #( true #nil #symbol ) ) printString]
		evaluatesTo: '#(#(1 2 3 nil) #() #(true ''nil'' ''symbol''))'.
	self
		assert: [ 
			{ 
				Object new.
				#( true nil ).
				nil.
				12.4.
				#someSymbol.
				(true and: [ false ]).
				[  ] } printString]
		evaluatesTo:
		'an Array(an Object #(true nil) nil 12.4 ''someSymbol'' false [] )'
]

{ #category : #testing }
PjObjectTest >> testShallowCopy [
	self assertBlock: [
		|original clone|
		original := Object new.
		original instVarNamed: #a put: 1. 
		clone := original copy.
		clone class == Object and: [ (clone instVarNamed: #a) = 1 ]
		 ]
]

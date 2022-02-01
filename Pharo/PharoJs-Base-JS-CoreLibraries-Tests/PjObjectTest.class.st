Class {
	#name : #PjObjectTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Objects'
}

{ #category : #testing }
PjObjectTest >> testNewObjectHasNoEnumeratableKeys [
	"This is important for many JS third party libraries"
	self assertBlock: [ Object new allEnumeratableKeys isEmpty ] .
]

{ #category : #testing }
PjObjectTest >> testPrintStringArray [

	self
		assert: [ #( 1 2 3 nil true #nil #symbol ) printString ]
		evaluatesTo: '#(1 2 3 nil true ''nil'' ''symbol'')'.
	self
		assert: [ 
		#( #( 1 2 3 nil ) #(  ) #( true #nil #symbol ) ) printString ]
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
				[ 42 factorial ] } printString ]
		evaluatesTo:
		'an Array(an Object #(true nil) nil 12.4 ''someSymbol'' false a Block)'
]

{ #category : #testing }
PjObjectTest >> testPrintStringBasicCases [

	self assert: [ Object new printString ] evaluatesTo: 'an Object'.
	self assert: [ PjSet new printString ] evaluatesTo: 'a PjSet()'.
	self
		assert: [ 'hello world' printString ]
		evaluatesTo: '''hello world'''.
	self
		assert: [ 'DragN''Drop' printString ]
		evaluatesTo: '''DragN''''Drop'''.
	self assert: [ true printString ] evaluatesTo: 'true'.
	self assert: [ false printString ] evaluatesTo: 'false'.
	self assert: [ nil printString ] evaluatesTo: 'nil'.
	self
		assert: [ #someSymbol printString ]
		evaluatesTo: '''someSymbol'''
]

{ #category : #testing }
PjObjectTest >> testPrintStringException [

	{ 
		Error.
		ZeroDivide } do: [ :exceptionClass | 
		self
			assert: [ exceptionClass new description ]
			evaluatesTo: exceptionClass name.
		self
			assert: [ 
				exceptionClass new
					messageText: 'Some cause';
					description ]
			evaluatesTo: exceptionClass name , ': Some cause' ]
]

{ #category : #testing }
PjObjectTest >> testPrintStringNumbers [

	self assert: [ 123 printString ] evaluatesTo: '123'.
	self
		assert: [ Float infinity printString ]
		evaluatesTo: 'Float infinity'.
	self
		assert: [ Float nan printString ]
		evaluatesTo: 'Float nan'.
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

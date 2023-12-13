Class {
	#name : #PjObjectTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Objects'
}

{ #category : #tests }
PjObjectTest >> assert: parent andChild: child hasOrInheritProperty: ivName [
	| objects |
	child  instVarNamed: #'__proto__' put: parent. 
	objects := { parent. child }.
	objects do: [: each | self deny: (each hasOrInheritsProperty: ivName)].
	parent instVarNamed: ivName put: nil.
	objects do: [: each | self assert: (each hasOrInheritsProperty: ivName)].

]

{ #category : #tests }
PjObjectTest >> testClassHasOrInheritProperty [
	| jsObject jsArray |
	jsArray := self evalBlock: [ Array ].
	jsObject := self evalBlock: [ Object ].
	self assertBlock: [jsArray superclass == jsObject].
	self assert: jsObject andChild: jsArray hasOrInheritProperty: #classIV.
	
	
]

{ #category : #tests }
PjObjectTest >> testNewObjectHasNoEnumeratableKeys [
	"This is important for many JS third party libraries"
	self assertBlock: [ Object new allEnumeratableKeys isEmpty ] .
]

{ #category : #tests }
PjObjectTest >> testObjectHasOrInheritProperty [
	| parent child |
	parent := self evalBlock: [ Object new ].
	child :=  self evalBlock: [ Object new ].
	self assert: parent andChild: child hasOrInheritProperty: #instanceIV.
	
]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
PjObjectTest >> testPrintStringNumbers [

	self assert: [ 123 printString ] evaluatesTo: '123'.
	self
		assert: [ Float infinity printString ]
		evaluatesTo: 'Float infinity'.
	self
		assert: [ Float nan printString ]
		evaluatesTo: 'Float nan'.
]

{ #category : #tests }
PjObjectTest >> testShallowCopy [
	self assertBlock: [
		|original clone|
		original := Object new.
		original instVarNamed: #a put: 1. 
		clone := original copy.
		clone class == Object and: [ (clone instVarNamed: #a) = 1 ]
		 ]
]

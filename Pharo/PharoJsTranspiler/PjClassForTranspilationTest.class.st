"
I am a class to be validated with PjTranspilerTest
"
Class {
	#name : #PjClassForTranspilationTest,
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
	#category : #'PharoJsTranspiler-Tests-Support'
}

{ #category : #'accessing structure variables' }
PjClassForTranspilationTest class >> a [
	^ A
]

{ #category : #'accessing structure variables' }
PjClassForTranspilationTest class >> b [
	^ B
]

{ #category : #any }
PjClassForTranspilationTest class >> c1 [
]

{ #category : #any }
PjClassForTranspilationTest class >> c2 [
]

{ #category : #'pharojs support' }
PjClassForTranspilationTest class >> classMethodJsGenerator [
	<pharoJsSkip>
	^self name asJSON
]

{ #category : #any }
PjClassForTranspilationTest class >> click: ev [
	| m |
	m := self setupMessage ifNil: [^ self].
	^ m
]

{ #category : #any }
PjClassForTranspilationTest class >> initialize [
	A := #testA.

]

{ #category : #'pharojs support' }
PjClassForTranspilationTest class >> instanceMethodJsGenerator [
	<pharoJsSkip>
	^'return 1', ' + ', '2;'
]

{ #category : #'pharojs support' }
PjClassForTranspilationTest class >> javascriptName [
	<pharoJsSkip>
	^  #JsClass
]

{ #category : #'pharojs support' }
PjClassForTranspilationTest class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^ {
		PjNullMessageConversionForTest -> #(selectors).
		PjClientForJavascriptInitializationTest class -> #(javascriptInitialize).
	}
]

{ #category : #'pharojs support' }
PjClassForTranspilationTest class >> jsTranspilationImportMethodsNonstandard [
	<pharoJsSkip>
	^ {
		PjNullMessageConversionForTest -> #(selector order:selector:).
		PjClassExtensionForTest class -> #(javascriptName exampleForTest).
	}
]

{ #category : #any }
PjClassForTranspilationTest class >> m1 [
	X := prototype.
	S := S.
	C := C.

]

{ #category : #any }
PjClassForTranspilationTest class >> methodWithJsGenerator [
	<jsGenerator: #classMethodJsGenerator>
]

{ #category : #any }
PjClassForTranspilationTest class >> setupMessage [
	^ (self == PjClassForTranspilationTest ifTrue: [
				''
			] ifFalse: [
				'Sorry, ']) ,
		'Click anywhere'

]

{ #category : #any }
PjClassForTranspilationTest >> @ op [
]

{ #category : #any }
PjClassForTranspilationTest >> add: op1 and: op2 [
	^op2
]

{ #category : #any }
PjClassForTranspilationTest >> blocksReferencingSelf [
	[self].
	^self
]

{ #category : #any }
PjClassForTranspilationTest >> cascade: x [
	^ x foo bar;yourself
]

{ #category : #any }
PjClassForTranspilationTest >> cascadeNested [
	^ self m1;m:(self m1; m2);yourself
]

{ #category : #any }
PjClassForTranspilationTest >> cascadeSelf [
	^ self m1;m:4;yourself
]

{ #category : #any }
PjClassForTranspilationTest >> cascadeSuper [
	^ super isNil;yourself
]

{ #category : #any }
PjClassForTranspilationTest >> composedCalls [
	^ (self m1 m:4) m2
]

{ #category : #any }
PjClassForTranspilationTest >> insanceMethodWithJsGenerator [
		<jsGenerator: #instanceMethodJsGenerator>
	^self
]

{ #category : #any }
PjClassForTranspilationTest >> m1 [
	X := prototype.
	S := S.
	C := C.

]

{ #category : #any }
PjClassForTranspilationTest >> m2 [
]

{ #category : #any }
PjClassForTranspilationTest >> m: in [
	<javascript: 'console.log("abc")'>
	^self
]

{ #category : #any }
PjClassForTranspilationTest >> methodToSkip [
		<pharoJsSkip>
		^#ThisShouldBeSkipped
]

{ #category : #any }
PjClassForTranspilationTest >> methodWithPoolVars [
	A := A.
	B := B.
	C := C.
	S := S.
	X := X.
	Y := Y.

]

{ #category : #any }
PjClassForTranspilationTest >> native [
	| x |
	x := x js_at: 4.
	x := x js_at: #foo.
	x := x js_at: 'a.b'.
	x js_at: 4 put: 42.
	x js_m: 17
]

{ #category : #any }
PjClassForTranspilationTest >> nestedBlocksReferencingSelf [
	[[self]].
	^1
]

{ #category : #any }
PjClassForTranspilationTest >> optimizeAtTest [
	| selectorCache aSelector |
	(selectorCache js_at: aSelector) ifNotNil: [ self ].
]

{ #category : #any }
PjClassForTranspilationTest >> toDoWithObjectAsParameter [
	1 to: 10 do: Object

]

{ #category : #any }
PjClassForTranspilationTest >> whileAtEnd [
	self m: [:x|	[ x m1 ] whileTrue].
	[ self m2 ] whileTrue.

]

{ #category : #any }
PjClassForTranspilationTest >> whileNotAtEnd [
	self m: [:x|	[ x m1 ] whileTrue].
	[ self m2 ] whileTrue.
	^ 42
]

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
	#category : #'PharoJs-Base-Transpiler-Tests-Support'
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
PjClassForTranspilationTest class >> classMethod_jsGenerator: transpiler [
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
PjClassForTranspilationTest class >> instanceMethod_jsGenerator: transpiler [
	<pharoJsSkip>
	^'return 1', ' + ', '2;'
]

{ #category : #'pharojs support' }
PjClassForTranspilationTest class >> isJsClassPlaceholder [

	<pharoJsSkip>
	^ false
]

{ #category : #'pharojs support' }
PjClassForTranspilationTest class >> javascriptName [

	<pharoJsSkip>
	^ #JsClass
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
	<jsGenerator: #classMethod_jsGenerator:>
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
PjClassForTranspilationTest >> alias [
	<jsAlias: #myAlias>
	^ 42
]

{ #category : #any }
PjClassForTranspilationTest >> alias1: arg [
	<jsAlias: #myAlias1 >
	^ arg + 1
]

{ #category : #any }
PjClassForTranspilationTest >> alias1Caller [
	<javascript: 'return this.myAlias1(41)'>
]

{ #category : #any }
PjClassForTranspilationTest >> alias1Caller: arg [ 
	<javascript: 'return this.myAlias1(arg)'>
]

{ #category : #any }
PjClassForTranspilationTest >> alias2 [
	<jsAlias: #myAlias2 and: #andAlias2>
	^ 21
]

{ #category : #any }
PjClassForTranspilationTest >> alias2Caller [
	<javascript: 'return this.myAlias2() + this.andAlias2()'>
]

{ #category : #any }
PjClassForTranspilationTest >> aliasCaller [
	<javascript: 'return this.myAlias()'>
]

{ #category : #any }
PjClassForTranspilationTest >> aliasSpecialName [
	<jsAlias: #'_$$_special'>
	^ 42
]

{ #category : #any }
PjClassForTranspilationTest >> aliasSpecialNameCaller [
	<javascript: 'return this._$$_special()'>
]

{ #category : #any }
PjClassForTranspilationTest >> blockWithNamedParameter [
"	self m2 ifNotNil: [ : foo | foo m2 ].
"	^ self m1 ifNotNil: [ : foo | foo m1 ]
]

{ #category : #any }
PjClassForTranspilationTest >> blockWithUnnamedParameter [
	^ self m1 ifNil: [ 42 ]
]

{ #category : #any }
PjClassForTranspilationTest >> blockWithUnnamedParameterNonTail [
	^ 3+(self m1 ifNil: [ 42 ])
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
PjClassForTranspilationTest >> instanceMethodWithJsGenerator [
		<jsGenerator: #instanceMethod_jsGenerator:>
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
PjClassForTranspilationTest >> twoPragmaWithAliases [

	<jsAlias: #firstAlias>
	<jsAlias: #secondAlias>
	^ 200
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

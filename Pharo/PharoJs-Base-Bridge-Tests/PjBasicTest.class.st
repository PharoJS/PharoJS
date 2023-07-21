Class {
	#name : #PjBasicTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #tests }
PjBasicTest >> testBasicEquality [

	self assertBlock: [ 312 ] equalsBlock: [ 312 ].
	self denyBlock: [ 312 ] equalsBlock: [ 5 ].
	self assertBlock: [ 'one two three' ] equalsBlock: [ 'one two three' ].
	self assertBlock: [ 'one two three' ] equalsBlock: [ 'one ', 'two', ' three' ].
	self denyBlock: [ 'one two three' ] equalsBlock: [ 'one three' ].
]

{ #category : #tests }
PjBasicTest >> testBooleanMethods [

	self assertEquivalent: [ true asBit ].
	self assertEquivalent: [ false asBit ]
]

{ #category : #tests }
PjBasicTest >> testCallingNewOnAJsConstructorViaFullProxy [

	| o1 o2 |
	self bridge evalJavascript: 'window.MyClass = class MyClass{
		x(){
			return this.x;
		}
		y(){
			return this.y;
		}
		z(){
			return this.z;
		}
		constructor(a, b, c){
			this.x = a;
			this.y = b;
			this.z = c;
		}
	}'.
	o1 := (window instVarNamed: #MyClass) new: 1 with: 2 with: 3.
	self assert: o1 x equals: 1.
	self assert: o1 y equals: 2.
	self assert: o1 z equals: 3.
	o2 := (window instVarNamed: #MyClass) new: 77 with: 88 with: 99.
	self assert: o2 x equals: 77.
	self assert: o2 y equals: 88.
	self assert: o2 z equals: 99
]

{ #category : #tests }
PjBasicTest >> testClosedBlocks [
	<expectedFailure>
	
	| x |
	self fail: 'Fix error'.
	x := 3.
	self assertEquivalent: [ [ x + 39 ] value ] asClosedBlock.
	x := 5.
	self assertEquivalent: [ x + 39 ] asClosedBlock
]

{ #category : #tests }
PjBasicTest >> testClosure [

	self assertEquivalent: [| tot coll |
		tot := 0.
		coll := OrderedCollection new.
		1 to: 5 do: [ : each | coll add: [ each ] ].
		coll do: [  : each | tot := tot + each value ].
		tot
	].
]

{ #category : #tests }
PjBasicTest >> testDifferentIdentities [

	self assertEquivalent: [false ~~ true].
]

{ #category : #tests }
PjBasicTest >> testEqualityAndDifferenceWithNil [

	self assertEquivalent: [ 0 = nil ].
	self assertEquivalent: [ 0 ~= nil ].
	self assertEquivalent: [ nil = 0 ].
	self assertEquivalent: [ nil ~= 0 ]
]

{ #category : #tests }
PjBasicTest >> testEvalResult [

	self checkBasic: 42.
	self checkBasic: true.
	self checkBasic: false.
	self checkBasic: 'abc'.
	self checkBasic: 'a\b''c"d'.
	self checkProxy: nil.
	self
		should: [ 
			(PjMessageErrorResponse newWithContents: 'a Javascript error') 
				getValueWithBridge: self bridge ]
		raise: PjJavascriptError
]

{ #category : #tests }
PjBasicTest >> testExceptionHandling [

	self assert: [|exceptionSignaled|
			exceptionSignaled := false.
			[Error signal]on: Error do: [exceptionSignaled := true].
			exceptionSignaled]
	  evaluatesTo: true.
	self assert: [|exceptionSignaled|
			exceptionSignaled := false.
			[3+4]on: Error do: [exceptionSignaled := true].
			exceptionSignaled]
	  evaluatesTo: false.
]

{ #category : #tests }
PjBasicTest >> testHash [

	self assertEquivalent: [nil hash].
	self assertEquivalent: [0 hash].
	self assertEquivalent: [ 1234 hash].
	self assertEquivalent: [true hash].
	self assertEquivalent: [false hash].
	self assert: ['abc' hash ] evaluatesTo: 135459374. " not the same as on Pharo, but uses same code with different initialization "
	self assertEquivalent: [|x| x:= Object new. x hash = x hash].
	self assertEquivalent: [|x y| x:= Object new. y:= Object new. x hash ~= y hash].
]

{ #category : #tests }
PjBasicTest >> testIdentity [

	self assertEquivalent: [ false == false ]
]

{ #category : #tests }
PjBasicTest >> testIfNilIfNotNil [

	self assertEquivalent: [ nil ifNil: [ 1 ] ].
	self assertEquivalent: [ false ifNotNil: [ 2 ] ].
	self assertEquivalent: [ nil ifNil: [ 1 ] ifNotNil: [ 2 ] ].
	self assertEquivalent: [ false ifNil: [ 1 ] ifNotNil: [ 2 ] ].
	self
		assert: [ 
			(document getElementById: #notInTheDocument)
				ifNil: [ 1 ]
				ifNotNil: [ 2 ] ]
		evaluatesTo: 1
]

{ #category : #tests }
PjBasicTest >> testIfTrueIfFalse [

	self assertEquivalent: [ true ifTrue: [1] ] .
	self assertEquivalent: [ false ifFalse: [2] ].
	self assertEquivalent: [ false ifTrue: [1] ] .
	self assertEquivalent: [ true ifFalse: [2] ].
	self assertEquivalent: [ true ifTrue: [1] ifFalse: [2] ].
	self assertEquivalent: [ false ifTrue: [1] ifFalse: [2] ].
	self assertEquivalent: [ true ifFalse: [2] ifTrue: [1] ].
	self assertEquivalent: [ false ifFalse: [2] ifTrue: [1] ] 
]

{ #category : #tests }
PjBasicTest >> testJsGlobalAccess [

	self
		assert: (self bridge evalBlock: [ Date ])
		equals: (self bridge jsGlobalAt: #Date).
	self assert: (self bridge evalBlock: [ Object ]) equals: (self bridge jsGlobalAt: #Object)
]

{ #category : #tests }
PjBasicTest >> testMethodsForBitManipulation [

	self assertEquivalent: [ -257 bitShift: -4 ].
	self assertEquivalent: [ 257 bitShift: -4 ].
	self assertEquivalent: [ -257 bitShift: 4 ].
	self assertEquivalent: [ 257 bitShift: 4 ].
	self assertEquivalent: [ -5 bitAnd: -11 ].
	self assertEquivalent: [ 5 bitAnd: 11 ].
	self assertEquivalent: [ -5 bitAnd: 11 ].
	self assertEquivalent: [ 5 bitAnd: 11 ].
	self assertEquivalent: [ -5 bitOr: -11 ].
	self assertEquivalent: [ 5 bitOr: 11 ].
	self assertEquivalent: [ -5 bitOr: 11 ].
	self assertEquivalent: [ 5 bitOr: 11 ].
	self assertEquivalent: [ -5 bitXor: -11 ].
	self assertEquivalent: [ 5 bitXor: 11 ].
	self assertEquivalent: [ -5 bitXor: 11 ].
	self assertEquivalent: [ 5 bitXor: 11 ].
	self assertEquivalent: [ 1234567 highBit ].
	self assertEquivalent: [ 12300000 lowBit ].
	self assertEquivalent: [ -12300000 lowBit ].
]

{ #category : #tests }
PjBasicTest >> testMethodsForNumbers [

	self assertEquivalent: [ -3 abs ].
	self assertEquivalent: [ 0 abs ].
	self assertEquivalent: [ 3 abs ].
	self assertEquivalent: [ 0 sign ].
	self assertEquivalent: [ 4 sign ].
	self assertEquivalent: [ -25 sign ].
	self assertEquivalent: [ 30 degreesToRadians ].
	self assertEquivalent: [ 1.78 radiansToDegrees ].
]

{ #category : #tests }
PjBasicTest >> testMultilineConstants [

	self assertEquivalent: [ 
		'this
			and that' size ].
	self assertEquivalent: [ #( 1 2 3 4 5 6 ) size ]
]

{ #category : #tests }
PjBasicTest >> testNumber [

	| x |
	self assertEquivalent: [ 1 ].
	self assertEquivalent: [ 2 asInteger ].
	self assertEquivalent: [ 2.5 asInteger ].
	self assertEquivalent: [ 2 asFloat ].
	self assertEquivalent: [ 2.5 asFloat ].
	self assertEquivalent: [ 2 asNumber ].
	self assertEquivalent: [ 2.5 asNumber ].
	self assertEquivalent: [ '2' asNumber ].
	self assertEquivalent: [ '2.5' asNumber ].
	self assertEquivalent: [ [ 3 / 1 ] on: ZeroDivide do: [ 42 ] ].
	self assertEquivalent: [ [ 3 / 0 ] on: ZeroDivide do: [ 42 ] ].
	self assertEquivalent: [ [ 3.0 / 0 ] on: ZeroDivide do: [ 42 ] ].
	self assertEquivalent: [ [ 3.0 / 2 ] on: ZeroDivide do: [ 42 ] ].
	self assertEquivalent: [ [ 3 // 0 ] on: ZeroDivide do: [ 42 ] ].
	self assertEquivalent: [ [ 3 // 1 ] on: ZeroDivide do: [ 42 ] ].
	self assertEquivalent: [ [ 3.0 // 0 ] on: ZeroDivide do: [ 42 ] ].
	self assertEquivalent: [ [ 3.0 // 2 ] on: ZeroDivide do: [ 42 ] ].
	x := 1.5e300.
	self assertEquivalent: [ x * x  ]. " Infinity "
	self assertEquivalent: [ x negated * x ]. " -Infinity "
	self assertEquivalent: [ x * x * 0 ]. " NaN "
	self assertEquivalent: [ (x * x * 0) isNaN ]. " NaN "
]

{ #category : #tests }
PjBasicTest >> testResettingTheApp [

	self resetApp.
	self assert: app identicalTo: self currentApp.
]

{ #category : #tests }
PjBasicTest >> testResettingTheClient [

	self bridge resetClient.
	self assert: self bridge isConnected
]

{ #category : #tests }
PjBasicTest >> testSignalingExceptionFromJavaScript [

	self
		should: [ 
			self bridge evalBlock: [ 
				Object new testSignalingExceptionFromJavaScript ] ]
		raise: PjJavascriptError
]

{ #category : #tests }
PjBasicTest >> testSimpleMathOperations [

	self assertEquivalent: [ 1+2 ].
	self assertEquivalent: [ 6*7 ].
	self assertEquivalent: [ (2 + 4) * (3 + 4) ].
	self assertEquivalent: [ 2 + 4 * 7 ].
	self assertEquivalent: [ 2 + 4 * (3 + 4) ].
	self assertEquivalent: [ (3 + 4) odd ].
	self assertEquivalent: [ (3 * 4) odd ].
	self assertEquivalent: [ (3 + 4) even ].
	self assertEquivalent: [ (3 * 4) even ].
]

{ #category : #tests }
PjBasicTest >> testTimesRepeat [

	self
		assertEquivalent: [|counter|
			counter := 0.
			5 timesRepeat: [counter := counter + 1].
			counter].
]

{ #category : #tests }
PjBasicTest >> testToDoBy [

	self assertEquivalent: [ 
		| tot |
		tot := 0.
		1 to: 2 by: 1 do: [ :i | tot := tot + 1 ].
		tot ].
	self assertEquivalent: [ 
		| tot |
		tot := 0.
		2 to: 1 by: 1 do: [ :i | tot := tot + 1 ].
		tot ].
	self assertEquivalent: [ 
		| tot |
		tot := 0.
		2 to: 1 by: -1 do: [ :i | tot := tot + 1 ].
		tot ]
]

{ #category : #tests }
PjBasicTest >> testUnicode [

	self assert: $€ asJSON equals: '"\u20AC"'.
	self assert: 'ab€cd' asJSON equals: '"ab\u20ACcd"'.
	self checkBasic: 'ab€cd'.
]

{ #category : #tests }
PjBasicTest >> testValueBlock0Arg [

	self assertEquivalent: [ [1+2] value ]
]

{ #category : #tests }
PjBasicTest >> testValueBlock1Arg [

	self assertEquivalent: [ [ : x | x + 2] value: 1 ]
]

{ #category : #tests }
PjBasicTest >> testValues [

	self assertEquivalent: [ 42 value ].
	self assertEquivalent: [ true value ].
	self assertEquivalent: [ false value ].
	self assertEquivalent: [ 'abc' value ]
]

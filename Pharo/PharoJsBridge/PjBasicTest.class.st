Class {
	#name : #PjBasicTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsBridge-Tests'
}

{ #category : #testing }
PjBasicTest >> expectedFailures [
^ #(testClosedBlocks)
]

{ #category : #testing }
PjBasicTest >> testBooleanMethods [
	self assertEquivalent: [true asBit].
	self assertEquivalent: [false asBit].

]

{ #category : #testing }
PjBasicTest >> testCallingNewOnAJsConstructorViaFullProxy [
	| o1 o2 |
	window instVarNamed:#MyConstructor put: [: a : b : c |
		self js_this instVarNamed:#x put: a.
		self js_this instVarNamed:#y put: b.
		self js_this instVarNamed:#z put: c.
	].
	o1 := (window instVarNamed:#MyConstructor) new: 1 with: 2 with: 3.
	self assert: o1 x equals: 1.
	self assert: o1 y equals: 2.
	self assert: o1 z equals: 3.
	o2 := (window instVarNamed:#MyConstructor) new: 77 with: 88 with: 99.
	self assert: o2 x equals: 77.
	self assert: o2 y equals: 88.
	self assert: o2 z equals: 99.

]

{ #category : #testing }
PjBasicTest >> testClosedBlocks [
	| x |
	self fail: 'Fix error'.
	x := 3.
	self assertEquivalent: [ [ x + 39 ] value ] asClosedBlock.
	x := 5.
	self assertEquivalent: [ x + 39 ] asClosedBlock
]

{ #category : #testing }
PjBasicTest >> testDifferentIdentities [
	self assertEquivalent: [false ~~ true].

]

{ #category : #testing }
PjBasicTest >> testEqualityAndDifferenceWithNil [
	self assertEquivalent: [0=nil].
	self assertEquivalent: [0~=nil].
	self assertEquivalent: [nil=0].
	self assertEquivalent: [nil~=0].

]

{ #category : #testing }
PjBasicTest >> testEvalResult [
	self checkBasic: 42.
	self checkBasic: true.
	self checkBasic: false.
	self checkBasic: 'abc'.
	self checkBasic: 'a\b''c"d'.
	self checkProxy: nil.
	self should: [ (bridge evalResult: '{"exception":"a Javascript error"}') value ] raise: PjJavascriptError

]

{ #category : #testing }
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

{ #category : #testing }
PjBasicTest >> testIdentity [
	self assertEquivalent: [false == false].

]

{ #category : #testing }
PjBasicTest >> testIfNilIfNotNil [
	self assertEquivalent: [nil ifNil: [1]].
	self assertEquivalent: [false ifNotNil: [2]].
	self assertEquivalent: [nil ifNil: [1] ifNotNil: [2]].
	self assertEquivalent: [false ifNil: [1] ifNotNil: [2]].
	self assert: [(document getElementById: #notInTheDocument) ifNil: [1] ifNotNil: [2]] evaluatesTo: 1
]

{ #category : #testing }
PjBasicTest >> testIfTrueIfFalse [
	self assertEquivalent: [true ifTrue: [1]] .
	self assertEquivalent: [false ifFalse: [2]].
	self assertEquivalent: [true ifTrue: [1] ifFalse: [2]].
	self assertEquivalent: [false ifTrue: [1] ifFalse: [2]].
	self assertEquivalent: [true ifFalse: [2] ifTrue: [1]].
	self assertEquivalent: [false ifFalse: [2] ifTrue: [1]].


]

{ #category : #testing }
PjBasicTest >> testJavascriptSemanticsComparisons [
" can't use assertEquivalent: because these are errors in Smalltalk "
	self assert: [nil>=0] evaluatesTo: false.
	self assert: [nil>0] evaluatesTo: false.
	self assert: [nil<=0] evaluatesTo: false.
	self assert: [nil<0] evaluatesTo: false.
	self assert: [0>=nil] evaluatesTo: false.
	self assert: [0>nil] evaluatesTo: false.
	self assert: [0<=nil] evaluatesTo: false.
	self assert: [0<nil] evaluatesTo: false.

]

{ #category : #testing }
PjBasicTest >> testMethodsForNumbers [
	self assertEquivalent: [-3 abs].
	self assertEquivalent: [0 abs].
	self assertEquivalent: [3 abs].
	self assertEquivalent: [0 sign].
	self assertEquivalent: [4 sign].
	self assertEquivalent: [-25 sign].

]

{ #category : #testing }
PjBasicTest >> testMultilineConstants [
	self assertEquivalent: ['this
			and that' size].
	self assertEquivalent: [#(1 2 3
			4 5 6) size].

]

{ #category : #testing }
PjBasicTest >> testNumber [
	self assertEquivalent: [ 1 ].

]

{ #category : #testing }
PjBasicTest >> testResettingTheClient [
	bridge resetClient.
	self assert: bridge isConnected.
]

{ #category : #testing }
PjBasicTest >> testSignalingExceptionFromJavaScript [
	self should: [
			bridge evalBlock: [Object new testSignalingExceptionFromJavaScript]]
		raise: PjJavascriptError
]

{ #category : #testing }
PjBasicTest >> testSimpleMathOperations [
	self assertEquivalent: [1+2].
	self assertEquivalent: [6*7].
	self assertEquivalent: [(2 + 4) * (3 + 4)].
	self assertEquivalent: [2 + 4 * 7].
	self assertEquivalent: [2 + 4 * (3 + 4)].
	self assertEquivalent: [(3 + 4) odd].
	self assertEquivalent: [(3 * 4) odd].
	self assertEquivalent: [(3 + 4) even].
	self assertEquivalent: [(3 * 4) even].

]

{ #category : #testing }
PjBasicTest >> testTimesRepeat [
	self
		assertEquivalent: [|counter|
			counter := 0.
			5 timesRepeat: [counter := counter + 1].
			counter].

]

{ #category : #testing }
PjBasicTest >> testValueBlock0Arg [
	self assertEquivalent: [[1+2] value].

]

{ #category : #testing }
PjBasicTest >> testValueBlock1Arg [
	self assertEquivalent: [[ : x | x + 2] value: 1].

]

{ #category : #testing }
PjBasicTest >> testValues [
	self assertEquivalent: [ 42 value ].
	self assertEquivalent: [ true value ].
	self assertEquivalent: [ false value ].
	self assertEquivalent: [ 'abc' value ].
]

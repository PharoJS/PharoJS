"
I am the class with actual benchmark code.

I have 4 class methods for the actual benchmarks, and a variety of instance methods to support them.

"
Class {
	#name : #PjTimingApplication,
	#superclass : #Object,
	#instVars : [
		'index'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsTiming-Application'
}

{ #category : #timings }
PjTimingApplication class >> allTimingOn: timer [
	| x y instance |
	x := 0.
	y := 1.
	instance := self new.
	self on: timer time: 'empty' with: [ ].
	self on: timer time: 'add-1' with: [ x := x + 1 ].
	self on: timer time: 'add-y' with: [ x := x + y ].
	self on: timer time: 'add-expr' with: [ x := x + instance one ].
	self on: timer time: 'fieldSetI' with: [ y := instance index: 3 ].
	self on: timer time: 'fieldSetV' with: [ y := instance instVarNamed:#index put: 3].
	self on: timer time: 'fieldGetI' with: [ y := instance index ].
	self on: timer time: 'fieldGetV' with: [ y := instance instVarNamed:#index ].
	self on: timer time: 'message' with: [ instance ten ].
	self on: timer time: 'cond-return' with: [ instance conditionalReturn ].
	self on: timer time: 'nonlocal' with: [ instance nonlocalReturn ].
	self on: timer time: 'nonlocal-block' with: [ instance nonlocalReturn2 ].
	self on: timer time: 'repeatLoop' with: [ instance repeatLoop ].
	self on: timer time: 'toDoLoop' with: [ instance toDoLoop ].
	self on: timer time: 'whileLoop' with: [ instance whileLoop ].
	self on: timer time: 'unoptLoop' with: [ instance whileRemoteLoop ].
	self on: timer time: 'DeltaBlue' with: [
		PjDbPlanner chainTest: 100. 
		PjDbPlanner projectionTest: 100
	] ratio: 0.0003.
	self on: timer time: 'Richards' with: [ PjRbBenchmark start ] ratio: 0.00005.

]

{ #category : #timings }
PjTimingApplication class >> browserTimingOn: timer [
	self on: timer time: 'docBody' with: [ document body ].
]

{ #category : #timings }
PjTimingApplication class >> jsTimingOn: timer top: top [
	| x y |
	x := self makeObject.
	y := 0.
	self on: timer time: 'fieldSet' with: [ x index: 1 ].
	self on: timer time: 'fieldSetN' with: [ x js_at:#index put: 1 ].
	self on: timer time: 'fieldSetX' with: [ x instVarNamed:#index put: 1 ].
	self on: timer time: 'fieldGet' with: [ y := x index ].
	self on: timer time: 'fieldGetN' with: [ y := x js_at:#index ].
	self on: timer time: 'fieldGetX' with: [ y := x instVarNamed:#index ]
]

{ #category : #'js support' }
PjTimingApplication class >> makeObject [
	"just here so we can create it the PharoJS and the Amber way"
	<javascript:	'var x={};x.index=42;return x'>
	<amberJSCode:	'var x={};x.index=42;return $globals.JSObjectProxy._on_(x)'>
]

{ #category : #timings }
PjTimingApplication class >> nodeTimingOn: timer [

]

{ #category : #running }
PjTimingApplication class >> on: aTimingApp time: desc with: block [
	self on: aTimingApp time: desc with: block ratio: 1
]

{ #category : #running }
PjTimingApplication class >> on: aTimingApp time: desc with: block ratio: ratio [
	aTimingApp prefix: '(warmup)'.
	aTimingApp warmups timesRepeat: [aTimingApp time: desc with: block ratio: ratio].
	aTimingApp prefix: ''.
	aTimingApp runs timesRepeat: [aTimingApp time: desc with: block ratio: ratio]
]

{ #category : #running }
PjTimingApplication class >> runTimings: aTimingApp [
	aTimingApp log: 'Running ', aTimingApp iterations asString,' iterations'.
	aTimingApp time.
	aTimingApp log: 'Done'
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> conditionalReturn [
	self ten > 5 ifTrue: [ ^ #yes ].
	^ #no
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> conditionalReturn2: aBlock [
	self ten > 5 ifTrue: aBlock.
	^ #no
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> conditionalReturn: aBlock [
	self ten > 5 ifTrue: [aBlock value].
	^ #no
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> index [
	^ index
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> index: anInteger [
	index := anInteger
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> nonlocalReturn [
	self conditionalReturn: [ ^ #yes ].
	^ #no
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> nonlocalReturn2 [
	self conditionalReturn2: [ ^ #yes ].
	^ #no
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> one [
	^ 1
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> repeatLoop [
	| x |
	x := 0.
	10 timesRepeat: [ x := x + 1 ].
	^ x
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> ten [
	^ 7500
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> toDoLoop [
	| x |
	x := 0.
	1 to: 10 do: [ : y | x := x + y ].
	^ x
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> whileLoop [
	| x y |
	x := y := 0.
	[ y < 10 ] whileTrue: [ y := y + 1. x := x + y ].
	^ x
]

{ #category : #'as yet unclassified' }
PjTimingApplication >> whileRemoteLoop [
	| x y b1 b2 |
	x := y := 0.
	b1 := [ y < 10 ].
	b2 := [ y := y + 1. x := x + y ].
	b1 whileTrue: b2.
	^ x
]

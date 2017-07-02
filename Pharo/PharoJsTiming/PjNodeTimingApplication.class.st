"
I am the class that provides comparative timing on NodeJS.

I run tests that have no explicit reference to Javascript objects, tests that reference generic top-level object, and tests that are specific to NodeJS.
"
Class {
	#name : #PjNodeTimingApplication,
	#superclass : #PjNodeApplication,
	#instVars : [
		'iterations',
		'prefix',
		'printedIterations'
	],
	#category : #'PharoJsTiming-Application'
}

{ #category : #'as yet unclassified' }
PjNodeTimingApplication class >> appClasses [
	<pharoJsSkip>
	^ super appClasses, 
		{ PjTimingApplication }
]

{ #category : #'as yet unclassified' }
PjNodeTimingApplication class >> appJsFileName [
	<pharoJsSkip>
	^ 'node.js'
]

{ #category : #'as yet unclassified' }
PjNodeTimingApplication class >> playgroundDoNotList [
	< pharoJsSkip >
]

{ #category : #'as yet unclassified' }
PjNodeTimingApplication class >> start [
	| instance |
	instance := self new.
	PjTimingApplication runTimings: instance
]

{ #category : #'as yet unclassified' }
PjNodeTimingApplication >> initialize [
	printedIterations := iterations := 1000000
]

{ #category : #'as yet unclassified' }
PjNodeTimingApplication >> iterations [
	^ iterations
]

{ #category : #'as yet unclassified' }
PjNodeTimingApplication >> log: aString [
	console log: aString
]

{ #category : #'as yet unclassified' }
PjNodeTimingApplication >> prefix: aString [
	prefix := aString
]

{ #category : #'as yet unclassified' }
PjNodeTimingApplication >> runs [
	^ 10
]

{ #category : #'as yet unclassified' }
PjNodeTimingApplication >> time [
	PjTimingApplication allTimingOn: self.
	PjTimingApplication jsTimingOn: self top: global.
	PjTimingApplication nodeTimingOn: self
]

{ #category : #'as yet unclassified' }
PjNodeTimingApplication >> time: aString with: aBlock ratio: ratio [
	| iters |
	iters := (iterations * ratio) asInteger.
	iters isZero ifTrue: [ iters := 1 ].
	printedIterations = iters ifFalse: [
		Transcript show: 'Running ';show: iters;show: ' iterations';cr.
		printedIterations := iters
	].
	console time: prefix,aString.
	iters timesRepeat: [aBlock value].
	console timeEnd: prefix,aString
]

{ #category : #'as yet unclassified' }
PjNodeTimingApplication >> warmups [
	^ 5
]

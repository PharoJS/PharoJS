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
	#category : #'PharoJs-Benchmarking-Application'
}

{ #category : #'accessing - description' }
PjNodeTimingApplication class >> appClasses [
	<pharoJsSkip>

	^ super appClasses , { PjTimingApplication }
]

{ #category : #'accessing - description' }
PjNodeTimingApplication class >> appJsFileName [
	<pharoJsSkip>

	^ 'node.js'
]

{ #category : #settings }
PjNodeTimingApplication class >> playgroundDoNotList [
	<pharoJsSkip>
]

{ #category : #'start-stop application' }
PjNodeTimingApplication class >> start [
	<script>
	
	PjTimingApplication runTimings: self new
]

{ #category : #accessing }
PjNodeTimingApplication >> cr [
	^self
]

{ #category : #initialization }
PjNodeTimingApplication >> initialize [
	printedIterations := iterations := 1000000
]

{ #category : #accessing }
PjNodeTimingApplication >> iterations [
	^ iterations
]

{ #category : #accessing }
PjNodeTimingApplication >> log: aString [
	console log: aString
]

{ #category : #accessing }
PjNodeTimingApplication >> prefix: aString [
	prefix := aString
]

{ #category : #accessing }
PjNodeTimingApplication >> runs [
	^ 10
]

{ #category : #accessing }
PjNodeTimingApplication >> show: aString [
	console log: aString
]

{ #category : #accessing }
PjNodeTimingApplication >> time [
	PjTimingApplication allTimingOn: self.
	PjTimingApplication jsTimingOn: self top: global.
	PjTimingApplication nodeTimingOn: self
]

{ #category : #accessing }
PjNodeTimingApplication >> time: aString with: aBlock ratio: ratio [
	| iters |
	iters := (iterations * ratio) asInteger.
	iters isZero ifTrue: [ iters := 1 ].
	printedIterations = iters ifFalse: [
		self show: 'Running ';show: iters;show: ' iterations';cr.
		printedIterations := iters
	].
	console time: prefix,aString.
	iters timesRepeat: [aBlock value].
	console timeEnd: prefix,aString
]

{ #category : #accessing }
PjNodeTimingApplication >> warmups [
	^ 5
]

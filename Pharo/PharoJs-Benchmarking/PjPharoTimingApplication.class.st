"
I am the class that provides comparative timing on Pharo or other native Smalltalk systems.

I only run tests that have no explicit reference to Javascript objects.
"
Class {
	#name : #PjPharoTimingApplication,
	#superclass : #Object,
	#instVars : [
		'iterations',
		'prefix',
		'printedIterations'
	],
	#category : #'PharoJs-Benchmarking-Application'
}

{ #category : #'start-stop application' }
PjPharoTimingApplication class >> start [
	<script>
	
	Transcript clear.
	PjTimingApplication runTimings: self new
]

{ #category : #accessing }
PjPharoTimingApplication >> cr [
	^self
]

{ #category : #initialization }
PjPharoTimingApplication >> initialize [
	printedIterations := iterations := 1000000
]

{ #category : #accessing }
PjPharoTimingApplication >> iterations [
	^ iterations
]

{ #category : #accessing }
PjPharoTimingApplication >> log: aString [
	Transcript show: aString;cr.
]

{ #category : #accessing }
PjPharoTimingApplication >> prefix: aString [
	prefix := aString
]

{ #category : #accessing }
PjPharoTimingApplication >> runs [
	^ 10
]

{ #category : #accessing }
PjPharoTimingApplication >> show: aString [
	Transcript show: aString;cr.
]

{ #category : #accessing }
PjPharoTimingApplication >> time [
	PjTimingApplication allTimingOn: self
]

{ #category : #accessing }
PjPharoTimingApplication >> time: aString with: aBlock ratio: ratio [
	| iters |
	iters := (iterations * ratio) asInteger.
	iters isZero ifTrue: [ iters := 1 ].
	printedIterations = iters ifFalse: [
		self show: 'Running ';show: iters;show: ' iterations';cr.
		printedIterations := iters
	].
	self
		show: prefix;
		show: aString;
		show: ': ';
		show:  (([ iters timesRepeat: aBlock ] timeToRunWithoutGC) printShowingDecimalPlaces: 3);
		show: 'ms';
		cr
]

{ #category : #accessing }
PjPharoTimingApplication >> warmups [
	^ 0
]

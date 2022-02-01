"
I am the class that provides comparative timing on browsers.

I run tests that have no explicit reference to Javascript objects, tests that reference generic top-level object, and tests that are specific to browsers with a DOM.
"
Class {
	#name : #PjBrowserTimingApplication,
	#superclass : #PjWebApplication,
	#instVars : [
		'iterations',
		'prefix',
		'printedIterations'
	],
	#category : #'PharoJs-Benchmarking-Application'
}

{ #category : #'as yet unclassified' }
PjBrowserTimingApplication class >> appClasses [
	<pharoJsSkip>
	^ super appClasses, 
		{ PjTimingApplication }
]

{ #category : #'as yet unclassified' }
PjBrowserTimingApplication class >> playgroundDoNotList [
	< pharoJsSkip >
]

{ #category : #'as yet unclassified' }
PjBrowserTimingApplication class >> start [
	PjTimingApplication runTimings: self new
]

{ #category : #'as yet unclassified' }
PjBrowserTimingApplication >> initialize [
	printedIterations := iterations := 1000000
]

{ #category : #'as yet unclassified' }
PjBrowserTimingApplication >> iterations [
	^ iterations
]

{ #category : #'as yet unclassified' }
PjBrowserTimingApplication >> log: aString [
	console log: aString.
	(document getElementById: #log) ifNotNil: [ : log | log innerHTML: log innerHTML, aString ]
]

{ #category : #'as yet unclassified' }
PjBrowserTimingApplication >> prefix: aString [
	prefix := aString
]

{ #category : #'as yet unclassified' }
PjBrowserTimingApplication >> runs [
	^ 10
]

{ #category : #'as yet unclassified' }
PjBrowserTimingApplication >> time [
	PjTimingApplication allTimingOn: self.
	PjTimingApplication jsTimingOn: self top: document.
	PjTimingApplication browserTimingOn: self
]

{ #category : #'as yet unclassified' }
PjBrowserTimingApplication >> time: aString with: aBlock ratio: ratio [
	| iters |
	iters := (iterations * ratio) asInteger.
	iters isZero ifTrue: [ iters := 1 ].
	printedIterations = iters ifFalse: [
		Transcript show: 'Running ';show: iters;show: ' iterations';cr.
		printedIterations := iters
	].
	console time: prefix,aString.
	iters timesRepeat: aBlock.
	console timeEnd: prefix,aString
]

{ #category : #'as yet unclassified' }
PjBrowserTimingApplication >> warmups [
	^ 5
]

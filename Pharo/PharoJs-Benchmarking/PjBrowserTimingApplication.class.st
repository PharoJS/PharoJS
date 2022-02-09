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

{ #category : #'accessing - description' }
PjBrowserTimingApplication class >> appClasses [
	<pharoJsSkip>
	
	^ super appClasses , { PjTimingApplication }
]

{ #category : #settings }
PjBrowserTimingApplication class >> playgroundDoNotList [
	<pharoJsSkip>
	
]

{ #category : #'start-stop application' }
PjBrowserTimingApplication class >> start [
	<script>
	
	PjTimingApplication runTimings: self new
]

{ #category : #initialization }
PjBrowserTimingApplication >> initialize [

	super initialize.
	printedIterations := iterations := 1000000
]

{ #category : #accessing }
PjBrowserTimingApplication >> iterations [

	^ iterations
]

{ #category : #accessing }
PjBrowserTimingApplication >> log: aString [

	console log: aString.
	(document getElementById: #log) ifNotNil: [ : log | log innerHTML: log innerHTML, aString ]
]

{ #category : #accessing }
PjBrowserTimingApplication >> prefix: aString [

	prefix := aString
]

{ #category : #accessing }
PjBrowserTimingApplication >> runs [

	^ 10
]

{ #category : #accessing }
PjBrowserTimingApplication >> time [

	PjTimingApplication allTimingOn: self.
	PjTimingApplication jsTimingOn: self top: document.
	PjTimingApplication browserTimingOn: self
]

{ #category : #accessing }
PjBrowserTimingApplication >> time: aString with: aBlock ratio: ratio [

	| iters |
	iters := (iterations * ratio) asInteger.
	iters isZero ifTrue: [ iters := 1 ].
	printedIterations = iters ifFalse: [ 
		Transcript
			show: 'Running ';
			show: iters;
			show: ' iterations';
			cr.
		printedIterations := iters ].
	console time: prefix , aString.
	iters timesRepeat: aBlock.
	console timeEnd: prefix , aString
]

{ #category : #accessing }
PjBrowserTimingApplication >> warmups [

	^ 5
]

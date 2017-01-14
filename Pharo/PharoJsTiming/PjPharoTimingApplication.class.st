"
I am the class that provides comparative timing on Pharo or other native Smalltalk systems.

I only run tests that have no explicit reference to Javascript objects.
"
Class {
	#name : #PjPharoTimingApplication,
	#superclass : #Object,
	#instVars : [
		'iterations',
		'prefix'
	],
	#category : #'PharoJsTiming-Application'
}

{ #category : #'as yet unclassified' }
PjPharoTimingApplication class >> time [
	<script>
	Transcript clear.
	PjTimingApplication runTimings: self new
]

{ #category : #'as yet unclassified' }
PjPharoTimingApplication >> initialize [
	iterations := 1000000
]

{ #category : #'as yet unclassified' }
PjPharoTimingApplication >> iterations [
	^ iterations
]

{ #category : #'as yet unclassified' }
PjPharoTimingApplication >> log: aString [
	Transcript show: aString;cr.

]

{ #category : #'as yet unclassified' }
PjPharoTimingApplication >> prefix: aString [
	prefix := aString
]

{ #category : #'as yet unclassified' }
PjPharoTimingApplication >> runs [
	^ 10
]

{ #category : #'as yet unclassified' }
PjPharoTimingApplication >> time [
	PjTimingApplication allTimingOn: self
]

{ #category : #'as yet unclassified' }
PjPharoTimingApplication >> time: aString with: aBlock [
	Transcript
		show: prefix;
		show: aString;
		show: ': ';
		show: 	(([ iterations timesRepeat: aBlock ] timeToRunWithoutGC ) printShowingDecimalPlaces: 3);
		show: 'ms';
		cr
]

{ #category : #'as yet unclassified' }
PjPharoTimingApplication >> warmups [
	^ 0
]

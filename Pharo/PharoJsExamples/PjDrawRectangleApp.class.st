"
I am just the shared methods of a minimal browser application.

My subclasses are the actual implementions.
"
Class {
	#name : #PjDrawRectangleApp,
	#superclass : #PjBrowserApplication,
	#instVars : [
		'rectangle',
		'colour'
	],
	#category : #'PharoJsExamples-DrawRectangle'
}

{ #category : #'event handling' }
PjDrawRectangleApp >> onLoad [
]

{ #category : #'event handling' }
PjDrawRectangleApp >> start [
	super start.
	self setupDOM
]

"
I am just the shared methods of a minimal browser application.

My subclasses are the actual implementions.
"
Class {
	#name : #PjDrawRectangleApp,
	#superclass : #PjWebApplication,
	#instVars : [
		'rectangle',
		'colour'
	],
	#category : #'PharoJs-Examples-DrawRectangle'
}

{ #category : #'event handling' }
PjDrawRectangleApp >> onLoad [
]

{ #category : #'event handling' }
PjDrawRectangleApp >> start [
	super start.
	self setupDOM
]

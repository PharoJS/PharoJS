"
I am a minimal application that runs in nodejs
"
Class {
	#name : #PjMinimalNodeApplication,
	#superclass : #PjNodeApplication,
	#traits : 'PjTMinimalApplication',
	#classTraits : 'PjTMinimalApplication classTrait',
	#category : #'PharoJs-Examples-Minimal'
}

{ #category : #'event handling' }
PjMinimalNodeApplication class >> start [
	super start.
	console log: 'this is a minimal Node application'
]

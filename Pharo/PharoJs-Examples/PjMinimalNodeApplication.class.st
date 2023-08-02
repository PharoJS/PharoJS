"
I am a minimal application that runs in nodejs
"
Class {
	#name : #PjMinimalNodeApplication,
	#superclass : #PjNodeApplication,
	#category : #'PharoJs-Examples-Minimal'
}

{ #category : #'node package management' }
PjMinimalNodeApplication class >> npmPackageNames [

	<pharoJsSkip>
	^ #( yes )
]

{ #category : #'event handling' }
PjMinimalNodeApplication class >> start [
	super start.
	console log: 'this is a minimal Node application'
]

"
I am a minimal application that runs in a web browser.

I demonstrate overriding the default html and css, and log to the console.
"
Class {
	#name : #PjMinimalWebApplication,
	#superclass : #PjWebApplication,
	#traits : 'PjTMinimalApplication',
	#classTraits : 'PjTMinimalApplication classTrait',
	#category : #'PharoJs-Examples-Minimal'
}

{ #category : #'pharojs support' }
PjMinimalWebApplication class >> css [
	^ 'body{color:blue}'
]

{ #category : #'event handling' }
PjMinimalWebApplication class >> log: message [
	console log: message
]

{ #category : #'event handling' }
PjMinimalWebApplication class >> start [
	super start.
	console log: 'this is a minimal Browser application'
]

"
I am a minimal application that runs in a web browser.

I demonstrate overriding the default html and css, and log to the console.
"
Class {
	#name : #PjMinimalBrowserApplication,
	#superclass : #PjBrowserApplication,
	#category : #'PharoJsExamples-Minimal'
}

{ #category : #'pharojs support' }
PjMinimalBrowserApplication class >> css [
	^ 'body{color:blue}'
]

{ #category : #'event handling' }
PjMinimalBrowserApplication class >> log: message [
	console log: message
]

{ #category : #'event handling' }
PjMinimalBrowserApplication class >> start [
	super start.
	console log: 'this is a minimal Browser application'
]

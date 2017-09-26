"
I am the class that all browser-based PharoJS applications should extend.

"
Class {
	#name : #PjBrowserApplication,
	#superclass : #PjDOMApplication,
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #PharoJsApp
}

{ #category : #'start-stop application' }
PjBrowserApplication class >> whenJsReady: aBlock [
	"The subscription to the load event is done in JS code only to allow running applications as pharo object. This is useful during development stages when all Pharo code runs on Pharo side, while a web browser provides JS objects."
	<javascript: 'window.addEventListener("load", aBlock)'>
	^aBlock value
]

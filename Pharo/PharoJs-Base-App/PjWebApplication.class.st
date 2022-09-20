"
I am the abstract superclass that all web-based PharoJS applications should extend (directly or indirectly). Those are apps that rely on HTML and run in a web browser or a web view 

"
Class {
	#name : #PjWebApplication,
	#superclass : #PjDOMApplication,
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJs-Base-App'
}

{ #category : #testing }
PjWebApplication class >> isAbstract [

	^ self = PjWebApplication
		  ifTrue: [ ^ true ]
		  ifFalse: [ super isAbstract ]
]

{ #category : #pj }
PjWebApplication class >> playgroundInitialContent [
	<pharoJsSkip>
	^	super playgroundInitialContent
		,'console dir: document.', String cr
		,'document fonts. " inspect this "', String cr
		,'document body style backgroundColor: ''#fee''.', String cr
]

{ #category : #private }
PjWebApplication class >> whenJsReady: aBlock [
	"The subscription to the load event is done in JS code only to allow running applications as pharo object. This is useful during development stages when all Pharo code runs on Pharo side, while a web browser provides JS objects."
	<javascript: 'window.addEventListener("load", aBlock)'>
	
	^ aBlock value
]

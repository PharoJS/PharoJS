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

{ #category : #'initialize-release' }
PjBrowserApplication >> start [
	self subscribeToDeviceEvents
]

{ #category : #'initialize-release' }
PjBrowserApplication >> stop [
	^self
]

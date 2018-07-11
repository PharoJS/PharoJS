"
Generic controller for DOM objects in web browser
"
Class {
	#name : #PjDomController,
	#superclass : #Object,
	#traits : 'PjTDomController',
	#classTraits : 'PjTDomController classTrait + PjTDomController',
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsCoreLibraries-Controllers'
}

{ #category : #accessing }
PjDomController class >> document [
	^document
]

{ #category : #accessing }
PjDomController >> document [
	^document
]

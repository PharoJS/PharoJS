"
Support multipage testing. Opens URLs in dedicated frame, so viewed pages are deleted once the viewer is closed upon test test tearDown. 
Because when navigating between different pages, the web browser forbides closing the window by a script different from the initial one that opens the window in the first place.
"
Class {
	#name : #PjPageViewerApp,
	#superclass : #PjWebApplication,
	#instVars : [
		'frame'
	],
	#category : #'PharoJs-Examples-ExpressJS'
}

{ #category : #'instance creation' }
PjPageViewerApp >> initialize [

	| firstElement |
	super initialize.
	frame := document createElement: #iframe.
	frame style: 'width:100%;height:', window innerHeight, 'px'.
	firstElement := document body childNodes first.
	document body insertBefore: frame existingNode: firstElement
]

{ #category : #'instance creation' }
PjPageViewerApp >> open: url [

	frame src: url.

]

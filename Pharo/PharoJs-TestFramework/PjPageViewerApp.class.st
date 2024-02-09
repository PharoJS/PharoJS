"
Support multipage testing (see PjMultipageExpressClientAppTest). Opens URLs in a dedicated frame, so viewed pages are deleted once the viewer is closed upon test tearDown. 
This viewer is needed when navigating between different pages, the web browser forbides closing a window by a script different from the initial one that opens the window in the first place.
"
Class {
	#name : #PjPageViewerApp,
	#superclass : #PjWebApplication,
	#instVars : [
		'frame'
	],
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #initialization }
PjPageViewerApp >> initialize [

	| firstElement |
	super initialize.
	frame := document createElement: #iframe.
	frame style: 'width:100%;height:', window innerHeight, 'px'.
	firstElement := document body childNodes first.
	document body insertBefore: frame existingNode: firstElement
]

{ #category : #'page viewing' }
PjPageViewerApp >> open: url [

	frame src: url.

]

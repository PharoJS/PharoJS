"
I am a web app that rely on a HTML file. My JS code is exported to a JS file that should be referenced by the HTML file.
"
Class {
	#name : #PjFileBasedWebApp,
	#superclass : #PjWebApplication,
	#category : #'PharoJs-Base-App'
}

{ #category : #testing }
PjFileBasedWebApp class >> isAbstract [

	^ self = PjFileBasedWebApp 
					ifTrue: [ ^ true ]
		  			ifFalse: [ super isAbstract ]
]

Class {
	#name : #PjMultipageExpressClientApp,
	#superclass : #PjWebApplication,
	#traits : 'PjTWebClientApp',
	#classTraits : 'PjTWebClientApp classTrait',
	#category : #'PharoJs-Examples-ExpressJS'
}

{ #category : #exporting }
PjMultipageExpressClientApp class >> serverAppClass [

	<pharoJsSkip>
	^ PjMultipageExpressApp 
]

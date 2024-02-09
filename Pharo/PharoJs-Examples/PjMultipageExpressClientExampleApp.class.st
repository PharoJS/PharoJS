Class {
	#name : #PjMultipageExpressClientExampleApp,
	#superclass : #PjWebApplication,
	#traits : 'PjTWebClientApp',
	#classTraits : 'PjTWebClientApp classTrait',
	#category : #'PharoJs-Examples-ExpressJS'
}

{ #category : #exporting }
PjMultipageExpressClientExampleApp class >> serverAppClass [

	<pharoJsSkip>
	^ PjMultipageExpressExampleApp 
]

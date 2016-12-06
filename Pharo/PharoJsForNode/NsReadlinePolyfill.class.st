Class {
	#name : #NsReadlinePolyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'Readline'
	],
	#category : #'PharoJsForNode-Utility'
}

{ #category : #API }
NsReadlinePolyfill class >> createInterface: objectDefiningInterface [
	<pharoJsSkip>

]

{ #category : #'pharojs globals' }
NsReadlinePolyfill class >> nodePackageName [
	<pharoJsSkip>
	^ 'readline'
]

{ #category : #API }
NsReadlinePolyfill >> on: event block: aBlock [
	<pharoJsSkip>

]

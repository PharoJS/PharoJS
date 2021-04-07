Class {
	#name : #PjTest1Polyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'Foobar'
	],
	#category : #'PharoJsExporterTests-Support'
}

{ #category : #polyfill }
PjTest1Polyfill class >> nodePackageName [
	<pharoJsSkip>
	^ 'foobar'
]

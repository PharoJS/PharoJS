Class {
	#name : #PjTest1Polyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'Foobar'
	],
	#category : #'PharoJsExporter-Tests-Support'
}

{ #category : #polyfill }
PjTest1Polyfill class >> nodePackageName [
	<pharoJsSkip>
	^ 'foobar'
]

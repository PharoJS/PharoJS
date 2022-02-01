Class {
	#name : #PjTest1Polyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'Foobar'
	],
	#category : #'PharoJs-Base-Exporter-Tests-Support'
}

{ #category : #polyfill }
PjTest1Polyfill class >> nodePackageName [
	<pharoJsSkip>
	^ 'foobar'
]

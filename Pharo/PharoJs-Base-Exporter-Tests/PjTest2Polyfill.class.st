Class {
	#name : #PjTest2Polyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'Bar'
	],
	#pools : [
		'PjTest1Polyfill'
	],
	#category : #'PharoJs-Base-Exporter-Tests-Support'
}

{ #category : #polyfill }
PjTest2Polyfill class >> nodePolyfill: aTranspiler [
	<pharoJsSkip>
	super nodePolyfill: aTranspiler.
	aTranspiler
		nextPutAll: 'var Bar=Foobar.Bar;';cr
]

{ #category : #polyfill }
PjTest2Polyfill class >> requiredPolyfills [
	^ self sharedPools
]

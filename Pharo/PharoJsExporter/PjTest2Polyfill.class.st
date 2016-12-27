Class {
	#name : #PjTest2Polyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'Bar'
	],
	#pools : [
		'PjTest1Polyfill'
	],
	#category : #'PharoJsExporter-Tests-Support'
}

{ #category : #polyfill }
PjTest2Polyfill class >> nodePolyfill: aStream [
	<pharoJsSkip>
	aStream
		nextPutAll: 'var Bar=Foobar.Bar;';cr
]

{ #category : #polyfill }
PjTest2Polyfill class >> requiredPolyfills [
	^ self sharedPools
]

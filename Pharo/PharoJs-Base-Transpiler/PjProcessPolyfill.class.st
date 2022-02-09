"
I am a polyfill to initialize some globals in a web browser.
"
Class {
	#name : #PjProcessPolyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'process'
	],
	#category : #'PharoJs-Base-Transpiler-Globals'
}

{ #category : #polyfill }
PjProcessPolyfill class >> browserPolyfill: aTranspiler [
	<pharoJsSkip>
	super browserPolyfill: aTranspiler.
	aTranspiler
		nextPutAll: 'var process=process||{exit:function(){window.close()}};';cr
]

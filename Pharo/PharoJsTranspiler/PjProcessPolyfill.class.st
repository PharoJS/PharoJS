"
I am a polyfill to initialize some globals in a web browser.
"
Class {
	#name : #PjProcessPolyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'process'
	],
	#category : #'PharoJsTranspiler-Globals'
}

{ #category : #polyfill }
PjProcessPolyfill class >> browserPolyfill: aStream [
	<pharoJsSkip>
	super browserPolyfill: aStream.
	aStream
		nextPutAll: 'var process=process||{exit:function(){window.close()}};';cr
]

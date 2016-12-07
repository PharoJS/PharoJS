"
I am the polyfill for WebSocket for Node.

This will force the appropriate package to be loaded when running on Node.
"
Class {
	#name : #PjWebSocketPolyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'WebSocket'
	],
	#category : #'PharoJsTranspiler-Globals'
}

{ #category : #'pharojs globals' }
PjWebSocketPolyfill class >> nodePackageName [
	<pharoJsSkip>
	^ 'ws'
]

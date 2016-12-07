"
I contain the globals for the NodeJS Javascript engine.

Use PjUniversalGlobals too
"
Class {
	#name : #PjNodeGlobals,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'module',
		'require'
	],
	#pools : [
		'PjProcessPolyfill',
		'PjUniversalGlobals',
		'PjWebSocketPolyfill'
	],
	#category : #'PharoJsTranspiler-Globals'
}

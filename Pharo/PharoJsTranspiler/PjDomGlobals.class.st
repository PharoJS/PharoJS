"
I contain the globals for all DOM-based Javascript engines

Use PjUniversalGlobals too
"
Class {
	#name : #PjDomGlobals,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'document',
		'history',
		'location',
		'navigator',
		'screen',
		'window'
	],
	#pools : [
		'PjProcessPolyfill',
		'PjUniversalGlobals',
		'PjWebSocketPolyfill'
	],
	#category : #'PharoJsTranspiler-Globals'
}

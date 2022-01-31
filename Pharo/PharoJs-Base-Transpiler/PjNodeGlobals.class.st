"
I contain the globals for the NodeJS Javascript engine.

"
Class {
	#name : #PjNodeGlobals,
	#superclass : #PjJavascriptGlobals,
	#pools : [
		'PjNodeMinGlobals',
		'PjWebSocketPolyfill'
	],
	#category : #'PharoJs-Base-Transpiler-Globals'
}

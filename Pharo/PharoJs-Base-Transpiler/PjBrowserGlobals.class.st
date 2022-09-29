"
I contain globals for all browser Javascript engines.

Use PjDomGlobals and PjUniversalGlobals too.
"
Class {
	#name : #PjBrowserGlobals,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'Float32Array',
		'FormData',
		'Image',
		'Uint16Array',
		'Uint8Array',
		'XMLHttpRequest',
		'localStorage'
	],
	#pools : [
		'PjDomGlobals',
		'PjUniversalGlobals'
	],
	#category : #'PharoJs-Base-Transpiler-Globals'
}

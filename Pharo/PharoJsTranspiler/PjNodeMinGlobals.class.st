"
I contain the globals for the Node-based Javascript engines including Electron

"
Class {
	#name : #PjNodeMinGlobals,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'module',
		'require'
	],
	#pools : [
		'PjProcessPolyfill',
		'PjUniversalGlobals'
	],
	#category : #'PharoJsTranspiler-Globals'
}

"
I contain globals for all browser Javascript engines.

Use PjDomGlobals and PjUniversalGlobals too.
"
Class {
	#name : #PjBrowserGlobals,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'XMLHttpRequest',
		'localStorage'
	],
	#pools : [
		'PjDomGlobals'
	],
	#category : #'PharoJsTranspiler-Globals'
}

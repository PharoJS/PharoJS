"
I represent a polyfill module for electron
"
Class {
	#name : #PjElectronPolyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'ElectronApp'
	],
	#category : #'PharoJs-Base-JS-Electron'
}

{ #category : #'pharojs globals' }
PjElectronPolyfill class >> nodePackageName [
	<pharoJsSkip>
	
	^ 'electron'
]

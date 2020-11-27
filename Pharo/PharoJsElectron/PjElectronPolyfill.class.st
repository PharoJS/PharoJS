Class {
	#name : #PjElectronPolyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'ElectronApp'
	],
	#category : #PharoJsElectron
}

{ #category : #'pharojs globals' }
PjElectronPolyfill class >> nodePackageName [
	<pharoJsSkip>
	^ 'electron'
]

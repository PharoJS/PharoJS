Class {
	#name : #NsFilesystemPolyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'Filesystem'
	],
	#category : #'PharoJsForNode-Utility'
}

{ #category : #API }
NsFilesystemPolyfill class >> existsSync: filename [
	<pharoJsSkip>
]

{ #category : #'pharojs globals' }
NsFilesystemPolyfill class >> nodePackageName [
	<pharoJsSkip>
	^ 'fs'
]

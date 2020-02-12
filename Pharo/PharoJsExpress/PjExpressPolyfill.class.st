"
An Express server
"
Class {
	#name : #PjExpressPolyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'ExpressServer'
	],
	#category : #PharoJsExpress
}

{ #category : #'pharojs globals' }
PjExpressPolyfill class >> nodePackageName [
	<pharoJsSkip>
	^ 'express'
]

{ #category : #polyfill }
PjExpressPolyfill class >> nodePolyfill: aStream [
	<pharoJsSkip>
	super nodePolyfill: aStream.
]

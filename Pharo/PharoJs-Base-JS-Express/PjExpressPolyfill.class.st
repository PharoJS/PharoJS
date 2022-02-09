"
An Express server

express node module required: $ npm install express
"
Class {
	#name : #PjExpressPolyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'ExpressServer'
	],
	#category : #'PharoJs-Base-JS-Express'
}

{ #category : #'pharojs globals' }
PjExpressPolyfill class >> nodePackageName [
	<pharoJsSkip>
	^ 'express'
]

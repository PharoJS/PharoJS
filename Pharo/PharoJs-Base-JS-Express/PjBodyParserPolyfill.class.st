"
A body parser. Useful for incoming requests to a node or express server.

body-parser node module required: $ npm install body-parser
"
Class {
	#name : #PjBodyParserPolyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'BodyParser'
	],
	#category : #'PharoJs-Base-JS-Express'
}

{ #category : #polyfill }
PjBodyParserPolyfill class >> nodePackageName [
	<pharoJsSkip>
	^ 'body-parser'
]

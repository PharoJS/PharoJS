"
I am the master class for all Javascript global sharedpools.

Subclasses may simply enumerate globals as class variables, or they may be polyfills that will emit some extra code to enable the appropriate global to be accessed.

Each polyfil subclass should override one or more of the *Polyfill: methods to write the necessary header code to install the polyfill
"
Class {
	#name : #PjJavascriptGlobals,
	#superclass : #SharedPool,
	#category : #'PharoJsTranspiler-Globals'
}

{ #category : #polyfill }
PjJavascriptGlobals class >> browserPolyfill: aTranspiler [
	<pharoJsSkip>

]

{ #category : #polyfill }
PjJavascriptGlobals class >> domPolyfill: aTranspiler [
	<pharoJsSkip>
]

{ #category : #'pharojs support' }
PjJavascriptGlobals class >> isJavascriptGlobalsPool [
	<pharoJsSkip>
	^ true
]

{ #category : #polyfill }
PjJavascriptGlobals class >> nodePackageName [
	<pharoJsSkip>
" override this with the name of the package to be require'd "
	^ nil
]

{ #category : #polyfill }
PjJavascriptGlobals class >> nodePolyfill: aTranspiler [
	<pharoJsSkip>
	self nodePackageName ifNil: [ ^ self ].
	self classVariables size = 1 ifFalse: [ PjJavascriptTranspilationError signal: 'node polyfills should only have 1 class variable' ].
	aTranspiler
		nextPutAll: 'var ';
		nextPutAll: self classVarNames first;
		nextPutAll: '=Smalltalk.require("';
		nextPutAll: self nodePackageName;
		nextPutAll: '");';cr
]

{ #category : #polyfill }
PjJavascriptGlobals class >> requiredPolyfills [
	^ #()
]

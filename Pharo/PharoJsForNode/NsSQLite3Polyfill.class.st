Class {
	#name : #NsSQLite3Polyfill,
	#superclass : #PjJavascriptGlobals,
	#classVars : [
		'SQLite'
	],
	#category : #'PharoJsForNode-SQL'
}

{ #category : #'pharojs globals' }
NsSQLite3Polyfill class >> nodePackageName [
	<pharoJsSkip>
	^ 'sqlite3'
]

{ #category : #API }
NsSQLite3Polyfill class >> serialize [
	<pharoJsSkip>
]

{ #category : #API }
NsSQLite3Polyfill class >> verbose [
	<pharoJsSkip>
]

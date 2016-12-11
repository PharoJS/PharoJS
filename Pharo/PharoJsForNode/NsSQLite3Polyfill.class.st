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

{ #category : #API }
NsSQLite3Polyfill >> all: commandString with: aDictionary callback: aBlock [
	<pharoJsSkip>
]

{ #category : #API }
NsSQLite3Polyfill >> each: commandString with: aDictionary callback: aBlockPerRow onCompletion: aBlock [
	<pharoJsSkip>
]

{ #category : #API }
NsSQLite3Polyfill >> get: commandString with: aDictionary callback: aBlock [
	<pharoJsSkip>
]

{ #category : #API }
NsSQLite3Polyfill >> run: commandString with: aDictionary callback: aBlock [
	<pharoJsSkip>
]

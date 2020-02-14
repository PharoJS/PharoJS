Class {
	#name : #PjTestClassForPolyfill,
	#superclass : #PjNodeApplication,
	#pools : [
		'PjTest2Polyfill'
	],
	#category : #'PharoJsExporter-Tests-Support'
}

{ #category : #accessing }
PjTestClassForPolyfill class >> pharoJsSelectorPrefix [
	^ 'alt_'
]

{ #category : #any }
PjTestClassForPolyfill >> m [
	| bar ws |
	bar := Bar new.
	ws := WebSocket new.
]

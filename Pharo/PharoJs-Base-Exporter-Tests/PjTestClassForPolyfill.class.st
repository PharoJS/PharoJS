Class {
	#name : #PjTestClassForPolyfill,
	#superclass : #PjNodeApplication,
	#pools : [
		'PjTest2Polyfill'
	],
	#category : #'PharoJs-Base-Exporter-Tests-Support'
}

{ #category : #accessing }
PjTestClassForPolyfill class >> pharoJsSelectorPrefix [
	^ 'alt_'
]

{ #category : #settings }
PjTestClassForPolyfill class >> playgroundDoNotList [

	<pharoJsSkip>
	
]

{ #category : #any }
PjTestClassForPolyfill >> m [
	| bar ws |
	bar := Bar new.
	ws := WebSocket new.
]

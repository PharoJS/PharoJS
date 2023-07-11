Class {
	#name : #PjRxParser,
	#superclass : #PjObject,
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjRxParser class >> javascriptName [ 
	^ 'RegExp'
]

{ #category : #testing }
PjRxParser >> matchesIn: aString [
	<javascript: 'return aString.match(this)'>
]

{ #category : #testing }
PjRxParser >> matchesIn: aString do: aBlock [
	| matches |
	console log: aString.
	console log: self.
	console log: (self matchesIn: aString).
	matches := (self matchesIn: aString).
	matches ifNil: [ ^ self ].
	^ matches do: aBlock
]

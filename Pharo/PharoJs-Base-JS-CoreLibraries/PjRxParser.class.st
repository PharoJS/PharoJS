"
I am a minimal implementation of RxParser.
"
Class {
	#name : #PjRxParser,
	#superclass : #PjObject,
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjRxParser class >> javascriptName [

	<pharoJsSkip>
	^ 'RegExp' 
]

{ #category : #testing }
PjRxParser >> matchesIn: aString [
	^ aString match: self
]

{ #category : #testing }
PjRxParser >> matchesIn: aString do: aBlock [
	| matches |
	matches := (self matchesIn: aString).
	matches ifNil: [ ^ self ].
	^ matches do: aBlock
]

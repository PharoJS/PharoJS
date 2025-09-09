"
I am a minimal implementation of RxParser.
"
Class {
	#name : 'PjRxParser',
	#superclass : 'PjObject',
	#category : 'PharoJs-Base-JS-CoreLibraries-Kernel',
	#package : 'PharoJs-Base-JS-CoreLibraries',
	#tag : 'Kernel'
}

{ #category : 'pharoJs support' }
PjRxParser class >> javascriptName [

	<pharoJsSkip>
	^ 'RegExp' 
]

{ #category : 'testing' }
PjRxParser >> matchesIn: aString [

	^ (aString match: self) ifNil: [ #() ]
]

{ #category : 'testing' }
PjRxParser >> matchesIn: aString do: aBlock [
	| matches |
	matches := (self matchesIn: aString).
	^ matches do: aBlock
]

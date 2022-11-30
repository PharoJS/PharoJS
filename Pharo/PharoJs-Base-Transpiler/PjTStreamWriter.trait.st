"
I provide implementations for common and low-level stream writing methods for PjStringGenerator, PjSelectorGenerator, and PjTranspiler
"
Trait {
	#name : #PjTStreamWriter,
	#category : #'PharoJs-Base-Transpiler-Kernel'
}

{ #category : #'Javascript names' }
PjTStreamWriter classSide >> jsNativePrefix [
	^ #js_
]

{ #category : #'writing low-level' }
PjTStreamWriter >> << aString [

	self jsStream << aString
]

{ #category : #'writing low-level' }
PjTStreamWriter >> cr [
	self jsStream nextPut: self lineEnding
]

{ #category : #accessing }
PjTStreamWriter >> jsNativePrefix [
	^ self class jsNativePrefix
]

{ #category : #accessing }
PjTStreamWriter >> jsStream [
	self explicitRequirement
]

{ #category : #accessing }
PjTStreamWriter >> lineEnding [
	self explicitRequirement
]

{ #category : #'writing low-level' }
PjTStreamWriter >> nextPut: char [
	self jsStream nextPut: char
]

{ #category : #'writing low-level' }
PjTStreamWriter >> nextPutAll: string [
	self jsStream nextPutAll: string
]

{ #category : #'writing low-level' }
PjTStreamWriter >> print: anObject [
	anObject printJsOn: self jsStream
]

{ #category : #'writing low-level' }
PjTStreamWriter >> space [
	self jsStream space
]

{ #category : #writing }
PjTStreamWriter >> writeJsSelector: aSelector onStream: aStream [
	| isBinary |
	(aSelector beginsWith: self jsNativePrefix) ifTrue: [ 
			^ aStream nextPutAll: ((aSelector keywords first allButFirst: self jsNativePrefix size) copyWithout: $:) ].
	isBinary := aSelector isBinary.
	aStream nextPutAll: self pharoJsSelectorPrefix.
	aSelector do:[ :each | 
			self writeSelectorChar: each on: aStream isInBinarySelector: isBinary ]
]

{ #category : #writing }
PjTStreamWriter >> writeSelectorChar: character on: aStream isInBinarySelector: isInBinarySelector [
	isInBinarySelector ifTrue: [ 
			character asciiValue printOn: aStream.
			^aStream nextPut: $_ ].
	character = $: ifTrue: [ 
		^aStream nextPut: $_ ].
	aStream nextPut: character
]

{ #category : #writing }
PjTStreamWriter >> writeVariable: aString escapingIfIn: aCollection [
	(aCollection includes: aString) ifTrue: [ self nextPut: $$ ].
	self nextPutAll: aString
]

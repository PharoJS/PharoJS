"
I am the common code for the simplistic ReadWriteStream.

Because strings and arrays are very different in Javascript,
I have subclasses that implement those differences.
"
Class {
	#name : #PjReadWriteStream,
	#superclass : #PjObject,
	#instVars : [
		'array',
		'position',
		'readLimit',
		'collection'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjReadWriteStream class >> jsTranspilationImportMethods [

	<pharoJsSkip>
	^ { 
		  (PositionableStream
		   ->
			   #( back isEmpty match: next: nextDelimited: peek peekBack
			      peekFor: position position: positionError reset resetContents
			      #setFrom:to: setToEnd skip: upTo: )).
		  (WriteStream -> #( << space tab )).
		  (Stream -> #( print: )) }
]

{ #category : #accessing }
PjReadWriteStream >> atEnd [
	position >= readLimit ifTrue: [ self contents ].
	^ position >= readLimit
]

{ #category : #accessing }
PjReadWriteStream >> contents [
	1 < array size ifTrue: [ self load: self join ].
	^ collection
]

{ #category : #'initialize-release' }
PjReadWriteStream >> emptyCollection [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
PjReadWriteStream >> initialize [
	super initialize.
	array := OrderedCollection with: (collection := self emptyCollection).
	readLimit := 0.
	position := 0.
]

{ #category : #accessing }
PjReadWriteStream >> join [
	^ self subclassResponsibility
]

{ #category : #accessing }
PjReadWriteStream >> load: temp [
	array := OrderedCollection with: temp.
	collection := temp.
	readLimit := temp size.
	^ temp
]

{ #category : #accessing }
PjReadWriteStream >> next [
	self atEnd ifTrue: [ ^ nil ].
	^ collection at: (position := position + 1)
]

{ #category : #accessing }
PjReadWriteStream >> nextPut: aCharacter [
	^ self subclassResponsibility
]

{ #category : #accessing }
PjReadWriteStream >> nextPutAll: aCollection [
	array addLast: aCollection.
	^ aCollection
]

{ #category : #accessing }
PjReadWriteStream >> on: temp [
	self load: temp.
	self reset.
]

{ #category : #accessing }
PjReadWriteStream >> skip: n [
	position := position + n.
]

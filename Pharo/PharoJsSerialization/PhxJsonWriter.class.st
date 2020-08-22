Class {
	#name : #PhxJsonWriter,
	#superclass : #PjDomController,
	#instVars : [
		'string',
		'knownObjects'
	],
	#category : #'PharoJsSerialization-Core'
}

{ #category : #writing }
PhxJsonWriter >> << aString [
	string := string , aString
	
]

{ #category : #writing }
PhxJsonWriter >> comma [
	self << ','
]

{ #category : #writing }
PhxJsonWriter >> doBetweenCurlyBraces: aBlock [
	self << '{'.
	aBlock value. 
	self << '}'
]

{ #category : #writing }
PhxJsonWriter >> doBetweenSquareBrackets: aBlock [
	self << '['.
	aBlock value. 
	self << ']'
]

{ #category : #writing }
PhxJsonWriter >> identityIndexOf: anObject [
	knownObjects
		doWithIndex: [ :obj :index | 
			obj == anObject
				ifTrue: [ ^ index ] ].
	^ nil
]

{ #category : #'initialize-release' }
PhxJsonWriter >> initialize [
	string := ''.
	knownObjects := OrderedCollection new
]

{ #category : #accessing }
PhxJsonWriter >> string [
	^ string
]

{ #category : #accessing }
PhxJsonWriter >> string: anObject [
	string := anObject
]

{ #category : #writing }
PhxJsonWriter >> writeKeyName: key andValue: anObject [
	self writeQuoted: key.
	self << ':'.
	anObject isBlock
		ifTrue: [ anObject value ]
		ifFalse: [ anObject
				ifNil: [ self << 'null' ]
				ifNotNil: [ self << anObject asJSON ] ]
]

{ #category : #writing }
PhxJsonWriter >> writeQuoted: aString [
	self << '"' << aString << '"'
]

{ #category : #writing }
PhxJsonWriter >> writeReferenceFor: anObject or: aBlock [
	(self identityIndexOf: anObject)
		ifNotNil: [ :i | 
			i isZero
				ifFalse: [ self
						doBetweenCurlyBraces: [ self writeKeyName: 'instRef' andValue: i ].
					^ self ] ].
	knownObjects add: anObject.
	aBlock value
]

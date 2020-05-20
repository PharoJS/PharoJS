"
I am the Javascript embodiment of Dictionary.

Note that the current implemenation uses objects, so only string keys are valid.
"
Class {
	#name : #PjDictionary,
	#superclass : #PjCollection,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharojs support' }
PjDictionary class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{
		Dictionary -> #(at:ifAbsentPut:).
	}

]

{ #category : #converting }
PjDictionary >> asDictionary [
	^self
]

{ #category : #converting }
PjDictionary >> asJsObject [
	| jsObject |
	jsObject := Object new.
	self keysAndValuesDo: [ : key : value |
		jsObject at: key put: value asJsObject].
	^jsObject
]

{ #category : #enumerating }
PjDictionary >> collect: aBlock [
	| resultDict |
	resultDict := self class new.
	self keysAndValuesDo: [: key : value |
		resultDict at: key put: (aBlock value: value)
	].
	^resultDict
]

{ #category : #enumerating }
PjDictionary >> reject: aBlock [
	| result |
	result := OrderedCollection new.
	self keysAndValuesDo: [: key : value |
		(aBlock value: value) ifFalse: [result addLast: value]
	].
	^ result
]

{ #category : #enumerating }
PjDictionary >> select: aBlock [
	| result |
	result := OrderedCollection new.
	self keysAndValuesDo: [: key : value |
		(aBlock value: value) ifTrue: [result addLast: value]
	].
	^ result
]

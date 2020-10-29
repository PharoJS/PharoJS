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

{ #category : #'dictionary access' }
PjDictionary >> at: key [
	^super at: (self keyFrom: key)
]

{ #category : #'dictionary access' }
PjDictionary >> at: key ifAbsent: aBlock [
	^super at: (self keyFrom: key) ifAbsent: aBlock
]

{ #category : #'dictionary access' }
PjDictionary >> at: key ifPresent: aBlock [
	^super at: (self keyFrom: key) ifPresent: aBlock
]

{ #category : #'dictionary access' }
PjDictionary >> at: key ifPresent: aBlock ifAbsent: anotherBlock [
	^super at: (self keyFrom: key) ifPresent: aBlock ifAbsent: anotherBlock
]

{ #category : #'dictionary access' }
PjDictionary >> at: key put: value [
	^super at: (self keyFrom: key) put: value

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

{ #category : #'dictionary access' }
PjDictionary >> keyFrom: anObject [
	anObject class == String ifTrue: [ ^anObject ].
	anObject class == Number ifTrue: [ ^anObject ].
	^anObject hash
]

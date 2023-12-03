"
I am the Javascript embodiment of Dictionary.

Note that the current implemenation uses objects, so only string keys are valid.
"
Class {
	#name : #PjDictionary,
	#superclass : #PjCollection,
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'pharojs support' }
PjDictionary class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{
		Dictionary -> #(at:ifAbsentPut:).
	}
]

{ #category : #testing }
PjDictionary >> = aDictionary [
	"Two dictionaries are equal if
	 (a) they are the same 'kind' of thing.
	 (b) they have the same set of keys.
	 (c) for each (common) key, they have the same value.
"

	self == aDictionary ifTrue: [^true].
	self species == aDictionary species ifFalse: [^false].
	self size = aDictionary size ifFalse: [^false].
	self keysAndValuesDo:  [:key : value|
		(aDictionary at: key ifAbsent: [^false]) = value
			ifFalse: [^false]].
	^true
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

{ #category : #converting }
PjDictionary >> becomeJsObject [

	self valuesDo: [ :value |
		value becomeJsObject ].

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

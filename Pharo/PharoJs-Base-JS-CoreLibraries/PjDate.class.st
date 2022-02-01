Class {
	#name : #PjDate,
	#superclass : #Object,
	#traits : 'PjTDate',
	#classTraits : 'PjTDate classTrait',
	#pools : [
		'ChronologyConstants'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Chronology'
}

{ #category : #'instance creation' }
PjDate class >> fromString: aString [
	<javascript: 'return new this(aString)'>
]

{ #category : #'pharoJs support' }
PjDate class >> javascriptName [
	<pharoJsSkip>
	^ #Date
]

{ #category : #'instance creation' }
PjDate class >> now [
	<javascript: 'return new this()'>
]

{ #category : #'instance creation' }
PjDate class >> today [
	^self now
]

{ #category : #converting }
PjDate >> asDateAndTime [
	^self
]

{ #category : #accessing }
PjDate >> dayOfMonth [
	^self getDate
]

{ #category : #accessing }
PjDate >> dayOfWeek [
	^self getDay + 1
]

{ #category : #accessing }
PjDate >> monthIndex [
	^self getMonth + 1
]

{ #category : #accessing }
PjDate >> monthIndex: anInteger [
	^self month: anInteger - 1
]

{ #category : #accessing }
PjDate >> year [
	^self getFullYear
]

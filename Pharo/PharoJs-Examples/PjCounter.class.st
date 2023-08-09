Class {
	#name : #PjCounter,
	#superclass : #Object,
	#instVars : [
		'count'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'PharoJs-Examples-Counter'
}

{ #category : #accessing }
PjCounter class >> createDefaultInstance [

	^defaultInstance := self new
]

{ #category : #accessing }
PjCounter class >> defaultInstance [

	^defaultInstance ifNil: [ self createDefaultInstance ].

]

{ #category : #accessing }
PjCounter class >> resetDefaultInstance [

	defaultInstance := nil
]

{ #category : #accessing }
PjCounter >> count [
	^ count
]

{ #category : #accessing }
PjCounter >> count: anObject [
	count := anObject
]

{ #category : #operations }
PjCounter >> increment [
	self count: self count + 1
]

{ #category : #'initialize - release' }
PjCounter >> initialize [
	super initialize.
	self reset
]

{ #category : #operations }
PjCounter >> reset [
	self count: 0
]

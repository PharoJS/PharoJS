Class {
	#name : #PjCounter,
	#superclass : #Object,
	#instVars : [
		'count'
	],
	#category : #'PharoJs-Examples-Counter'
}

{ #category : #accessing }
PjCounter >> count [
	^ count
]

{ #category : #accessing }
PjCounter >> count: anObject [
	count := anObject
]

{ #category : #'initialize - release' }
PjCounter >> increment [
	self count: self count + 1
]

{ #category : #'initialize - release' }
PjCounter >> initialize [
	super initialize.
	self reset
]

{ #category : #'initialize - release' }
PjCounter >> reset [
	self count: 0
]

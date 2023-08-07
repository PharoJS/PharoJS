Class {
	#name : #PjCircularCounter,
	#superclass : #PjCounter,
	#instVars : [
		'max'
	],
	#category : #'PharoJs-Examples-Counter'
}

{ #category : #'instance creation' }
PjCircularCounter class >> max: maxValue [
	^self new
		max: maxValue;
		yourself 
]

{ #category : #'initialize - release' }
PjCircularCounter >> defaultMax [
	^999
]

{ #category : #operations }
PjCircularCounter >> increment [ 
	self count = self max ifTrue: [ ^self count: 0 ].
	super increment
]

{ #category : #'initialize - release' }
PjCircularCounter >> initialize [

	super initialize.
	self max: self defaultMax
]

{ #category : #accessing }
PjCircularCounter >> max [

	^ max
]

{ #category : #accessing }
PjCircularCounter >> max: anObject [

	max := anObject
]

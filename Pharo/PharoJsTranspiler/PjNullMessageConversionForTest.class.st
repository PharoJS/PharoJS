"
I am a dummy PjOptimization to test the manager
"
Class {
	#name : #PjNullMessageConversionForTest,
	#superclass : #PjSpecialMessageConversion,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'selector'
	],
	#category : #'PharoJsTranspiler-Tests-Support'
}

{ #category : #optimization }
PjNullMessageConversionForTest >> convertReceiver: anObject args: aCollection [
	anObject value < order ifTrue: [ ^ order ].
	^ nil
]

{ #category : #initialization }
PjNullMessageConversionForTest >> order: aNumber selector: aString [ 
	self order: aNumber.
	selector := aString
]

{ #category : #accessing }
PjNullMessageConversionForTest >> selector [
	^ selector
]

{ #category : #accessing }
PjNullMessageConversionForTest >> selectors [
	^ {selector}
]

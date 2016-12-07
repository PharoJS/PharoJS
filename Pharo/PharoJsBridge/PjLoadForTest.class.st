"
I am a small, non-app class used in some interactive, manual, tests
"
Class {
	#name : #PjLoadForTest,
	#superclass : #Object,
	#classVars : [
		'X'
	],
	#category : #'PharoJsBridge-Tests'
}

{ #category : #any }
PjLoadForTest class >> fortyTwo [
	^ X ifNil: [ X := 42]
]

{ #category : #any }
PjLoadForTest class >> initialize [
	X := nil
]

{ #category : #any }
PjLoadForTest class >> reset [
	<pharoJsSkip>
	self initialize
]

{ #category : #any }
PjLoadForTest >> seventeen [
	^ X
]

{ #category : #any }
PjLoadForTest >> subtract: n [
	^ X := X - n
]

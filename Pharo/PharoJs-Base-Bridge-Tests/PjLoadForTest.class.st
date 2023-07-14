"
I am a small, non-app class used in some interactive, manual, tests
"
Class {
	#name : #PjLoadForTest,
	#superclass : #Object,
	#classVars : [
		'X',
		'Y',
		'Z'
	],
	#pools : [
		'PjUniversalGlobals'
	],
	#category : #'PharoJs-Base-Bridge-Tests-Support'
}

{ #category : #any }
PjLoadForTest class >> fortyTwo [

	^ X ifNil: [ X := 42 ]
]

{ #category : #any }
PjLoadForTest class >> initialize [

	Y := 'Y original'.
	Z := 'Z original'.
	X := nil
]

{ #category : #any }
PjLoadForTest class >> literal [
	<jsLiteralGenerator>
	
	^ 'abc','def'
]

{ #category : #any }
PjLoadForTest class >> reset [
	<pharoJsSkip>
	
	self initialize
]

{ #category : #any }
PjLoadForTest class >> setupClassVars [

	self classVarNames do: [ :key | 
		self classVarNamed: key put: key , ' value' ]
]

{ #category : #any }
PjLoadForTest class >> y [

	^ Y
]

{ #category : #any }
PjLoadForTest >> literal [
	<jsLiteralGenerator>
	^ 3 + 4
]

{ #category : #any }
PjLoadForTest >> seventeen [

	^ X
]

{ #category : #any }
PjLoadForTest >> subtract: n [

	^ X := X - n
]

{ #category : #any }
PjLoadForTest >> z [

	^ Z
]

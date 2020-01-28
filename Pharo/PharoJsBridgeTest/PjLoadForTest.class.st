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
	#category : #'PharoJsBridgeTest-Support'
}

{ #category : #any }
PjLoadForTest class >> fortyTwo [
	^ X ifNil: [ X := 42]
]

{ #category : #any }
PjLoadForTest class >> initialize [
	" don't do this at home, kids: i.e. you really shouldn't be testig if you are running on Pharo or a browser"
	" this is just here because Pharo 7 ships with a breakpoint set in the classVarNamed:put: method! "
"	JSON isPjProxyOrNil ifTrue: ["
		Y:='Y value'.
		Z:='Z value'.
"	] ifFalse: [
		self classVarNames do: [: key |
			self classVarNamed: key put: key,' value'
	]]."
	X := nil
]

{ #category : #any }
PjLoadForTest class >> reset [
	<pharoJsSkip>
	self initialize
]

{ #category : #any }
PjLoadForTest class >> y [
	^ Y
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

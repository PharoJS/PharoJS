"
I am the class that all PharoJS applications should extend.

I contain methods that DOM (Browser and PhoneGap) and NodeJS applications have in common.
"
Class {
	#name : #PjApplication,
	#superclass : #Object,
	#pools : [
		'PjUniversalGlobals'
	],
	#classInstVars : [
		'appFolder',
		'currentInstance',
		'port',
		'status',
		'cssFile'
	],
	#category : #PharoJsApp
}

{ #category : #description }
PjApplication class >> appClass [
	<pharoJsSkip>
	^ self
]

{ #category : #description }
PjApplication class >> appClasses [
	<pharoJsSkip>
	^ self appClass withAllSuperclasses
]

{ #category : #description }
PjApplication class >> appLaunchBlock [
	<pharoJsSkip>
	| appClass |
	appClass := self.
	^[ appClass start ] asClosedBlock
]

{ #category : #description }
PjApplication class >> appPackages [
	<pharoJsSkip>
	^ Set new
]

{ #category : #'instance creation' }
PjApplication class >> currentInstance [
	^ currentInstance
]

{ #category : #accessing }
PjApplication class >> headerLine [
	<pharoJsSkip>
	^nil
]

{ #category : #'instance creation' }
PjApplication class >> resetCurrentInstance [
	currentInstance := nil.
]

{ #category : #description }
PjApplication class >> setupCode [
	<pharoJsSkip>
		^''

]

{ #category : #'start-stop application' }
PjApplication class >> start [
	self currentInstance ifNil: [currentInstance := self new].
	self currentInstance start.

]

{ #category : #'start-stop application' }
PjApplication class >> stop [
	self currentInstance ifNil: [^self].
	self currentInstance stop.

]

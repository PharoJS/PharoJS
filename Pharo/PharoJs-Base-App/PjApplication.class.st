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
		'exportVersion'
	],
	#category : #'PharoJs-Base-App'
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
	
	^ nil
]

{ #category : #accessing }
PjApplication class >> pharoJsSelectorPrefix [
	<pharoJsSkip>
	
	^ 'pj_'
]

{ #category : #'instance creation' }
PjApplication class >> resetCurrentInstance [
	<script>
	
	currentInstance := nil
]

{ #category : #description }
PjApplication class >> setupCode [
	<pharoJsSkip>
	
	^ ''
]

{ #category : #'start-stop application' }
PjApplication class >> start [
	<script>
	
	self whenJsReady: [ self startInstance ]
]

{ #category : #private }
PjApplication class >> startInstance [
	
	self currentInstance ifNil: [ currentInstance := self new ].
	self currentInstance start
]

{ #category : #'start-stop application' }
PjApplication class >> stop [
	<script>
	
	self currentInstance ifNil: [ ^ self ].
	self currentInstance stop
]

{ #category : #private }
PjApplication class >> whenJsReady: aBlock [

	self subclassResponsibility
]

{ #category : #'start-stop' }
PjApplication >> start [
]

{ #category : #'start-stop' }
PjApplication >> stop [
]

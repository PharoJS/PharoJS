"
I use [expressJS](https://expressjs.com) to make a web app.
I assume that the target folder comply with the following :
- The folder is an npm initialized folder, i.e you have run `npm init`
- The expressJS package is installed, i.e. you have run `npm install express --save`

"
Class {
	#name : #PjExpressApp,
	#superclass : #PjNodeApplication,
	#instVars : [
		'server',
		'port'
	],
	#classInstVars : [
		'expressConstructorFunction'
	],
	#category : #'PharoJs-Base-App'
}

{ #category : #accessing }
PjExpressApp class >> expressConstructorFunction [
	^expressConstructorFunction ifNil: [ self initExpressConstructorFunction  ].
	
]

{ #category : #accessing }
PjExpressApp class >> initExpressConstructorFunction [

	^ expressConstructorFunction := Smalltalk require: 'express'
]

{ #category : #testing }
PjExpressApp class >> isAbstract [

	^ self = PjExpressApp 
		  ifTrue: [ ^ true ]
		  ifFalse: [ super isAbstract ]
]

{ #category : #initialization }
PjExpressApp >> defaultPort [
	^4321
]

{ #category : #initialization }
PjExpressApp >> expressConstructorFunction [
	^self class expressConstructorFunction
]

{ #category : #initialization }
PjExpressApp >> initialize [ 
	super initialize.
	server := self newServer.
	self port: self defaultPort.
]

{ #category : #initialization }
PjExpressApp >> newServer [
	^self expressConstructorFunction value
]

{ #category : #accessing }
PjExpressApp >> port [

	^ port
]

{ #category : #accessing }
PjExpressApp >> port: anObject [

	port := anObject
]

{ #category : #'start-stop' }
PjExpressApp >> start [ 
	super start.
	server listen: self port onStartDo: [ self startUpAction ]
]

{ #category : #'start-stop' }
PjExpressApp >> startUpAction [

	console log:
		self className , ' web app started on port ' , self port asString
]

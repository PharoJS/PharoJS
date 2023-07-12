"
I use [expressJS](https://expressjs.com) to make a web app.
I assume that the target folder comply with the following :
- The folder is an npm initialized folder, i.e you have run `npm init`
- The express node modules is installed, i.e. you should run `npm install express` in the app's folder

"
Class {
	#name : #PjExpressApp,
	#superclass : #PjNodeApplication,
	#instVars : [
		'server',
		'port'
	],
	#classInstVars : [
		'expressConstructorFunction',
		'bodyParserFactory'
	],
	#category : #'PharoJs-Base-App'
}

{ #category : #testing }
PjExpressApp class >> isAbstract [

	^ self = PjExpressApp 
		  ifTrue: [ ^ true ]
		  ifFalse: [ super isAbstract ]
]

{ #category : #accessing }
PjExpressApp >> bodyParser [
	^self moduleNamed: 'body-parser'
]

{ #category : #initialization }
PjExpressApp >> defaultPort [
	^4321
]

{ #category : #initialization }
PjExpressApp >> initialize [ 
	super initialize.
	server := self newServer.
	self port: self defaultPort.
]

{ #category : #initialization }
PjExpressApp >> newServer [

	^ (self moduleNamed: 'express') value
]

{ #category : #accessing }
PjExpressApp >> port [

	^ port
]

{ #category : #accessing }
PjExpressApp >> port: anObject [

	port := anObject
]

{ #category : #initialization }
PjExpressApp >> serveStaticFilesIn: localFolderName [

	| path serveStatic |
	path := self fullPathFor: localFolderName.
	serveStatic := self serveStaticFunction value: path.
	server use: serveStatic.

]

{ #category : #accessing }
PjExpressApp >> serveStaticFunction [

	^ self moduleNamed: 'serve-static'
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

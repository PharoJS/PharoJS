"
I use [expressJS](https://expressjs.com) to make a web app.
I assume that the target folder comply with the following :
- The folder is an npm initialized folder, i.e you have run `npm init`
- The express node modules is installed, i.e. you should run `npm install express` in the app's folder
- The [body-parser](https://expressjs.com/en/resources/middleware/body-parser.html): Parse incoming request bodies in a middleware before your handlers, available under the req.body property.
- Optional: [serve-static](https://expressjs.com/en/resources/middleware/serve-static.html): Create a new middleware function to serve files from within a given root directory. The file to serve will be determined by combining req.url with the provided root directory. When a file is not found, instead of sending a 404 response, this module will instead call next() to move on to the next middleware, allowing for stacking and fall-backs.

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

{ #category : #'node package management' }
PjExpressApp class >> npmPackageNames [

	<pharoJsSkip>
	^ #('express' 'body-parser')
]

{ #category : #accessing }
PjExpressApp >> bodyParser [

	^ self require: 'body-parser'
]

{ #category : #initialization }
PjExpressApp >> bodyParserMiddleware [

	"More options and alternatives such as json in body-parser module doc
	https://expressjs.com/en/resources/middleware/body-parser.html"

	^ self bodyParser text
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
	server use: self bodyParserMiddleware
]

{ #category : #initialization }
PjExpressApp >> newServer [

	^ (self require: 'express') value
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

	^ self require: 'serve-static'
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

"
Express-based app. Requires the following node packages be installed in the folder
	- [express](https://expressjs.com)
	- [body-parser](https://expressjs.com/en/resources/middleware/body-parser.html): Parse incoming request bodies in a middleware before your handlers, available under the req.body property.
	- [serve-static](https://expressjs.com/en/resources/middleware/serve-static.html): Create a new middleware function to serve files from within a given root directory. The file to serve will be determined by combining req.url with the provided root directory. When a file is not found, instead of sending a 404 response, this module will instead call next() to move on to the next middleware, allowing for stacking and fall-backs.

"
Class {
	#name : #PjHelloWorldExpressApp,
	#superclass : #PjExpressApp,
	#instVars : [
		'name'
	],
	#category : #'PharoJs-Examples-ExpressJS'
}

{ #category : #accessing }
PjHelloWorldExpressApp class >> clientAppClasses [

	<pharoJsSkip>
	^{PjHelloWorldExpressClientApp }
]

{ #category : #accessing }
PjHelloWorldExpressApp class >> staticFilesFolderName [
	^'public'
]

{ #category : #initialization }
PjHelloWorldExpressApp >> greetings [

	^ String streamContents: [ :str | 
		  str << 'ExpressJS says: Hello'.
		  self name ifNotNil: [ 
			  str
				  space;
				  << self name ].
		  str << $! ]
]

{ #category : #handlers }
PjHelloWorldExpressApp >> handlePostNameRequest: req response: res [

	"See 
	Request doc https://expressjs.com/en/4x/api.html#req
	Response doc https://expressjs.com/en/4x/api.html#res"

	self name: req body.
	res send: self name
]

{ #category : #initialization }
PjHelloWorldExpressApp >> initialize [

	super initialize.
	server get: '/name' handler: [ :req :res | res send: self name ].
	server
		post: '/name'
		handler: [ :req :res |
		self handlePostNameRequest: req response: res ].
	server
		get: '/greetings'
		handler: [ :req :res | res send: self greetings ]
]

{ #category : #accessing }
PjHelloWorldExpressApp >> name [

	^ name
]

{ #category : #accessing }
PjHelloWorldExpressApp >> name: anObject [

	name := anObject
]

Class {
	#name : #PjHelloWorldExpressApp,
	#superclass : #PjExpressApp,
	#instVars : [
		'name'
	],
	#category : #'PharoJs-Examples-ExpressJS'
}

{ #category : #initialization }
PjHelloWorldExpressApp >> greetings [

	^ String streamContents: [ :str | 
		  str << 'ExpressJS says: Hello'.
		  name ifNotNil: [ 
			  str
				  space;
				  << name ].
		  str << $! ]
]

{ #category : #handlers }
PjHelloWorldExpressApp >> handlePostNameRequest: req response: res [

	"See 
	Request doc https://expressjs.com/en/4x/api.html#req
	Response doc https://expressjs.com/en/4x/api.html#res"

	name := req body.
	res send: name
]

{ #category : #initialization }
PjHelloWorldExpressApp >> initialize [

	super initialize.
	server use: self bodyParserFactory text.
	server get: '/name' handler: [ :req :res | res send: name ].
	server
		post: '/name'
		handler: [ :req :res | 
		self handlePostNameRequest: req response: res ].
	server
		get: '/greetings'
		handler: [ :req :res | res send: self greetings ].

]

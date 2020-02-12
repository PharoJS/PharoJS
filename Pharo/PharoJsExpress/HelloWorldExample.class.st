"
A basic express server example

Usage 
1) From a playground > HelloWorldExample exportApp.
2) Locate the server.js file that was generated
3) $ npm install express
4) node server.js
"
Class {
	#name : #HelloWorldExample,
	#superclass : #PjExpressApp,
	#category : #PharoJsExpress
}

{ #category : #exporting }
HelloWorldExample class >> appJsFileName [
	<pharoJsSkip>
	^ 'server.js'
]

{ #category : #'start-stop' }
HelloWorldExample >> start [
	expressServer := ExpressServer new.
	self getRequest: '/' send: 'hello world from pharojs-express!'.
	self getRequest: '/json' json: '{ "name":'+'"John", "age":30, "city":"Toronto"}'.
	"add code to listen"
	self listen: 3000.
	^ expressServer.
]

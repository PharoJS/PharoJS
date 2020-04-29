"
A basic express server example

Usage 
1) From a playground > PjHelloWorldExample exportApp.
2) Locate the server.js file that was generated
3) $ npm install express
4) node server.js
"
Class {
	#name : #PjHelloWorldExample,
	#superclass : #PjExpressApp,
	#category : #PharoJsExpress
}

{ #category : #exporting }
PjHelloWorldExample class >> appJsFileName [
	<pharoJsSkip>
	^ 'server.js'
]

{ #category : #'start-stop' }
PjHelloWorldExample >> start [
	| john |
	server := ExpressServer new.
	self getRequest: '/' send: 'hello world from pharojs-express!'.
	john := 'John'.
	self getRequest: '/json' json: { #name -> john.  #age -> 30. #city -> 'Toronto'} asDictionary.
	self getRequest: '/json1' json: 'hello text'.
	self getRequest: '/json2' json: #(1 2 fred nil #nil).
	self getRequest: '/json3' json: 42.
	"add code to listen"
	self listen: 3000.
	^ server.
]

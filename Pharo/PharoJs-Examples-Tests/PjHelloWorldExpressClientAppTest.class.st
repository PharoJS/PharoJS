Class {
	#name : #PjHelloWorldExpressClientAppTest,
	#superclass : #PjHelloWorldExpressAppApiTest,
	#instVars : [
		'clientBridge',
		'clientBridgeClient',
		'clientApp'
	],
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #initialization }
PjHelloWorldExpressClientAppTest >> clientAppClass [
^PjHelloWorldExpressClientApp
]

{ #category : #initialization }
PjHelloWorldExpressClientAppTest >> setUp [

	| jsMessage |
	super setUp.
	clientBridgeClient := PjExpressJsClientAppBridgeClient 
		                      newWithAppClass: self clientAppClass.
	clientBridgeClient urlString: 'http://localhost:' , app port asString.
	clientBridge := PjBridge
		                bridgeForAppClass: self clientAppClass
		                client: clientBridgeClient.
	clientBridge start.
	jsMessage := PjJavascriptMessage
		             receiverId: self clientAppClass name
		             selector: #currentInstance
		             arguments: #(  ).
	self waitWhile: [ 
		clientApp := clientBridge evalMessage: jsMessage.
		clientApp isNil ]
]

{ #category : #initialization }
PjHelloWorldExpressClientAppTest >> tearDown [

	super tearDown.
	clientBridge tearDown
]

{ #category : #tests }
PjHelloWorldExpressClientAppTest >> testDisplayGreetingsNoName [

	self assert: clientApp greetingsContainer textContent equals: '---'.
	clientApp updateGreetingsButton click.
	self
		waitUntil: [clientApp greetingsContainer textContent
		= 'ExpressJS says: Hello!']
]

{ #category : #tests }
PjHelloWorldExpressClientAppTest >> testGreetingsUpdatedAfterSettingName [

	self assert: clientApp greetingsContainer textContent equals: '---'.
	clientApp nameInput value: 'Test Name'.
	clientApp setNameButton click.
	self waitUntil: [ 
		clientApp greetingsContainer textContent = 'ExpressJS says: Hello Test Name!' ]
]

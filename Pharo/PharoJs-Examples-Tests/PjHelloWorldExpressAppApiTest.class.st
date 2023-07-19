Class {
	#name : #PjHelloWorldExpressAppApiTest,
	#superclass : #PjWebServerAppTestCase,
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #'suite parameters' }
PjHelloWorldExpressAppApiTest class >> appClass [

	^ PjHelloWorldExpressApp 
]

{ #category : #tests }
PjHelloWorldExpressAppApiTest >> testHttpGetGreetings [

	| response |
	response := self get: '/greetings'.
	self assert: response contents equals: 'ExpressJS says: Hello!'.
	app name: 'Spiderman'.
	self assert: (self get: '/greetings') contents equals: 'ExpressJS says: Hello Spiderman!'.

]

{ #category : #tests }
PjHelloWorldExpressAppApiTest >> testHttpGetName [

	| response providedName |
	response := self get: '/name'.
	self assert: response code equals: 200.
	self assert: response contents equals: nil.
	providedName := 'Smalltalk Balloon'.
	app name: providedName.
	self assert: (self get: '/name') contents equals: providedName
]

{ #category : #tests }
PjHelloWorldExpressAppApiTest >> testHttpGetRoot [

	| response |
	response := self get: '/'.
	self assert: response isSuccess.
	self assert: (response contentType matches: ZnMimeType textHtml).
	self assert: (response contents includesSubstring: 'pharoJsLogo')
]

{ #category : #tests }
PjHelloWorldExpressAppApiTest >> testHttpPostName [

	| response name |
	name := 'PharoJS'.
	response := self post: '/name' text: name.
	self assert: response code equals: 200.
	self assert: response contents equals: name.
	self assert: (self get: '/name') contents equals: name.
	self
		assert: (self get: '/greetings') contents
		equals: 'ExpressJS says: Hello ' , name , '!'
]

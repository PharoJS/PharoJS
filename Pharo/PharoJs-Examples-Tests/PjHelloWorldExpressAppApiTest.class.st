Class {
	#name : #PjHelloWorldExpressAppApiTest,
	#superclass : #PjAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #'suite parameters' }
PjHelloWorldExpressAppApiTest class >> appClass [

	^ PjHelloWorldExpressApp 
]

{ #category : #tests }
PjHelloWorldExpressAppApiTest >> get: pathString [

	^ ZnEasy get: self urlString , pathString
]

{ #category : #tests }
PjHelloWorldExpressAppApiTest >> post: pathString text: aString [

	^ ZnEasy post: self urlString , pathString data: (ZnEntity text: aString)
]

{ #category : #tests }
PjHelloWorldExpressAppApiTest >> testHttpGetGreetings [

	| response |
	response := self get: '/greetings'.
	self assert: response contents equals: 'ExpressJS says: Hello!'
]

{ #category : #tests }
PjHelloWorldExpressAppApiTest >> testHttpGetName [

	| response |
	response := self get: '/name'.
	self assert: response code equals: 200.
	self assert: response contents equals: nil.

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

{ #category : #tests }
PjHelloWorldExpressAppApiTest >> urlString [

	^ 'http://localhost:4321'
]

Class {
	#name : #PjHelloWorldExpressAppTest,
	#superclass : #PjAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #'suite parameters' }
PjHelloWorldExpressAppTest class >> appClass [

	^ PjHelloWorldExpressApp 
]

{ #category : #tests }
PjHelloWorldExpressAppTest >> get: pathString [

	^ ZnEasy get: self urlString , pathString
]

{ #category : #tests }
PjHelloWorldExpressAppTest >> post: pathString data: anObject [

	^ ZnEasy post: self urlString , pathString data: anObject asByteArray
]

{ #category : #tests }
PjHelloWorldExpressAppTest >> testHttpGetGreetings [

	| response |
	response := self get: '/greetings'.
	self assert: response contents equals: 'ExpressJS says hello!'
]

{ #category : #tests }
PjHelloWorldExpressAppTest >> testHttpGetName [

	| response |
	response := self get: '/name'.
	self assert: response code equals: 200.
	self assert: response contents equals: nil.

]

{ #category : #tests }
PjHelloWorldExpressAppTest >> testHttpGetRoot [

	| response |
	self fail: #todo.
	response := self get: '/'.
	self assert: response contents equals: 'ExpressJS says hello!'
]

{ #category : #tests }
PjHelloWorldExpressAppTest >> testHttpPostName [

	| response name |
	name := 'PharoJS'.
	response := self post: '/name' data: name.
	self assert: response code equals: 200.
	self assert: response contents equals: name.
	self
		assert: (self get: '/name') contents
		equals: name .	
	self
		assert: (self get: '/greetings') contents
		equals: 'ExpressJS says: Hello ' , name , '!'
]

{ #category : #tests }
PjHelloWorldExpressAppTest >> urlString [

	^ 'http://localhost:4321'
]

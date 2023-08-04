Class {
	#name : #PjMinimalExpressAppApiTest,
	#superclass : #PjWebServerAppTestCase,
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #'suite parameters' }
PjMinimalExpressAppApiTest class >> appClass [

	^ PjMinimalExpressApp
]

{ #category : #tests }
PjMinimalExpressAppApiTest >> testGetStaticFile [

	| response |
	response := self get: '/pharoJsLogo.png'.
	self assert: response code equals: 200.
	self assert: response contents size equals: 31251
]

{ #category : #tests }
PjMinimalExpressAppApiTest >> testHttpGetAndPost [

	| response |
	self assert: (self get: '/data') contents isNil.
	response := self post: '/data' text: 'PharoJS'.
	self assert: response code equals: 200.
	self assert: (self get: '/data') contents equals: 'PharoJS'
]

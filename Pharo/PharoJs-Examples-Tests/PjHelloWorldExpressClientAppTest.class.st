Class {
	#name : #PjHelloWorldExpressClientAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #'suite parameters' }
PjHelloWorldExpressClientAppTest class >> appClass [

	^ PjHelloWorldExpressClientApp
]

{ #category : #running }
PjHelloWorldExpressClientAppTest >> debugBridgeResourceClass [

	^ self
	defaultBridgeResourceClass

]

{ #category : #accessing }
PjHelloWorldExpressClientAppTest >> defaultBridgeResourceClass [

	^ PjExpressJsClientBridgeTestResource
]

{ #category : #initialization }
PjHelloWorldExpressClientAppTest >> serverClass [
	^PjHelloWorldExpressApp 
]

{ #category : #tests }
PjHelloWorldExpressClientAppTest >> testDisplayGreetingsNoName [

	self assert: app greetingsContainer textContent equals: '---'.
	self clickElement: app updateGreetingsButton.
	self waitUntil: [ 
		app greetingsContainer textContent = 'ExpressJS says: Hello!' ]
]

{ #category : #tests }
PjHelloWorldExpressClientAppTest >> testGreetingsUpdatedAfterSettingName [

	self assert: app greetingsContainer textContent equals: '---'.
	app nameInput value: 'Test Name'.
	self clickElement: app setNameButton.
	self waitUntil: [ 
		app greetingsContainer textContent
		= 'ExpressJS says: Hello Test Name!' ]
]

{ #category : #initialization }
PjHelloWorldExpressClientAppTest >> urlPath [
	^'/'
]

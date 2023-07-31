Class {
	#name : #PjHelloWorldAppTest,
	#superclass : #PjWebAppTestCase,
	#instVars : [
		'nameInput',
		'sayHelloButton',
		'greetingMessageContainer'
	],
	#category : #'PharoJs-Examples-Tests-HelloWorld'
}

{ #category : #'suite parameters' }
PjHelloWorldAppTest class >> appClass [
	^PjHelloWorldApp
]

{ #category : #running }
PjHelloWorldAppTest >> setUp [
	super setUp.
	nameInput := document getElementById: #nameTextInput.
	sayHelloButton := document getElementById: #sayHelloButton.
	greetingMessageContainer := document getElementById: #greetingMessageContainer.
]

{ #category : #tests }
PjHelloWorldAppTest >> testSayHello [
	#(Luke Yoda 'Obi One') do: [ : name |
		self changeElement: nameInput value: name.
		self clickElement: sayHelloButton.
		self assert: (greetingMessageContainer innerHTML endsWith: name)
	]
]

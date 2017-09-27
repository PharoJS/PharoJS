Class {
	#name : #PjHelloWorldAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTWaitUntilReady',
	#classTraits : 'PjTWaitUntilReady classTrait',
	#instVars : [
		'nameInput',
		'sayHelloButton',
		'greetingMessageContainer'
	],
	#category : #'PharoJsExamples-HelloWorld'
}

{ #category : #'suite parameters' }
PjHelloWorldAppTest class >> appClass [
	^PjHelloWorldApp
]

{ #category : #testing }
PjHelloWorldAppTest class >> isAbstract [
	^self == PjHelloWorldAppTest
]

{ #category : #testing }
PjHelloWorldAppTest >> setUp [
	super setUp.
	nameInput := document getElementById: #nameTextInput.
	sayHelloButton := document getElementById: #sayHelloButton.
	greetingMessageContainer := document getElementById: #greetingMessageContainer.

]

{ #category : #testing }
PjHelloWorldAppTest >> testSayHello [
	#(Luke Yoda 'Obi One') do: [ : name |
		self changeElement: nameInput value: name.
		self clickElement: sayHelloButton.
		self assert: (greetingMessageContainer innerHTML endsWith: name)
	]

]

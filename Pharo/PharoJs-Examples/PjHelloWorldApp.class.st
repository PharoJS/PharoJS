"
Simple Hello World example. 
The app UI relies on an text input field and a button.
The HTML file is on GIT https://github.com/bouraqadi/PharoJS.git sub-folder PharoJsExamples/HelloWorld/

To generate the javascript index.js file, evaluate the following expression: 
PjHelloWorldApp exportApp
"
Class {
	#name : #PjHelloWorldApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'user'
	],
	#category : #'PharoJs-Examples-HelloWorld'
}

{ #category : #description }
PjHelloWorldApp class >> appClasses [
	<pharoJsSkip>
	^super appClasses, { PjUser }
]

{ #category : #'initialize-release' }
PjHelloWorldApp >> start [
	| nameInput sayHelloButton greetingMessageContainer |
	super start.
	user := PjUser new.
	nameInput := document getElementById: #nameTextInput.
	sayHelloButton := document getElementById: #sayHelloButton.
	nameInput addEventListener: #change block: [ user name: nameInput value ].
	greetingMessageContainer := document getElementById: #greetingMessageContainer.
	sayHelloButton addEventListener: #click block: [ greetingMessageContainer innerHTML: 'Hello ' , user name ]
]

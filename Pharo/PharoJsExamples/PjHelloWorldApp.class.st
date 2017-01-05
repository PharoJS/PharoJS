"
Simple Hello World example. 
The app UI relies on an text input field and a button.
The HTML file is on GIT https://github.com/bouraqadi/PharoJS.git sub-folder PharoJsExamples/HelloWorld/

To generate the javascript index.js file, evaluate the following expression: 
PjHelloWorldApp exportApp
"
Class {
	#name : #PjHelloWorldApp,
	#superclass : #PjFileBasedBrowserApp,
	#instVars : [
		'user'
	],
	#category : #'PharoJsExamples-HelloWorld'
}

{ #category : #description }
PjHelloWorldApp class >> appClasses [
	<pharoJsSkip>
	^super appClasses, { PjUser }
]

{ #category : #'initialize-release' }
PjHelloWorldApp >> start [
	| nameInput sayHelloButton |
	super start.
	user := PjUser new.
	nameInput := document getElementById: 'nameTextInput'.
	sayHelloButton := document getElementById: 'sayHelloButton'.
	nameInput addEventListener: #change block: [ user name: nameInput value ].
	sayHelloButton addEventListener: #click block: [ window alert: 'Hello ' , user name ]
]

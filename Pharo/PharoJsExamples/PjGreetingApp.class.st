"
Simple Hello World example. 
The app UI relies on an text input field and a button.
The HTML file is on GIT https://github.com/bouraqadi/PharoJS.git sub-folder PharoJsExamples/HelloWorld/
"
Class {
	#name : #PjGreetingApp,
	#superclass : #PjFileBasedBrowserApp,
	#instVars : [
		'user'
	],
	#category : #'PharoJsExamples-HelloWorld'
}

{ #category : #description }
PjGreetingApp class >> appClasses [
	<pharoJsSkip>
	^super appClasses, { PjUser }
]

{ #category : #'initialize-release' }
PjGreetingApp >> start [
	| nameInput sayHelloButton |
	super start.
	user := PjUser new.
	nameInput := document getElementById: 'nameTextInput'.
	sayHelloButton := document getElementById: 'sayHelloButton'.
	nameInput addEventListener: #change block: [ user name: nameInput value ].
	sayHelloButton addEventListener: #click block: [ window alert: 'Hello ' , user name ]
]

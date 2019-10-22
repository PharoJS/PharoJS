Class {
	#name : #PjPharoJsSayHello,
	#superclass : #WAComponent,
	#traits : 'PjTPharoJsForSeaside',
	#classTraits : 'PjTPharoJsForSeaside classTrait',
	#classInstVars : [
		'scriptCache'
	],
	#category : #PharoJsSeaside
}

{ #category : #accessing }
PjPharoJsSayHello class >> handlerName [
	^ 'PharoJS/hello'
]

{ #category : #initialization }
PjPharoJsSayHello class >> initialize [
	WAAdmin register: self asApplicationAt: self handlerName
]

{ #category : #hooks }
PjPharoJsSayHello class >> pharoJsAppClass [
	^PjHelloWorldApp
]

{ #category : #hooks }
PjPharoJsSayHello class >> scriptCache [
	^scriptCache
]

{ #category : #hooks }
PjPharoJsSayHello class >> scriptCache: jsCode [
	scriptCache := jsCode
]

{ #category : #rendering }
PjPharoJsSayHello >> renderContentOn: html [
	super renderContentOn: html.
	html heading: 'This is 100% Client side (PharoJS)'.
	html textInput id: #nameTextInput.
	html button
		id: #sayHelloButton;
		with: 'Say Hello'.
	html break.
	html paragraph id: #greetingMessageContainer.
]

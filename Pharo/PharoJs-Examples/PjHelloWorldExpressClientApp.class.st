"
I rely on the [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) to make REST calls on the ExpressJS-based server implemented by `PjHelloWorldExpressApp`.
"
Class {
	#name : #PjHelloWorldExpressClientApp,
	#superclass : #PjFileBasedWebApp,
	#category : #'PharoJs-Examples-ExpressJS'
}

{ #category : #accessing }
PjHelloWorldExpressClientApp class >> defaultAppFolderName [
	<pharoJsSkip>

	^ PjHelloWorldExpressApp staticFilesFolderName
]

{ #category : #accessing }
PjHelloWorldExpressClientApp class >> defaultAppFolderParent [

	<pharoJsSkip>
	^ PjHelloWorldExpressApp appFolder
]

{ #category : #acting }
PjHelloWorldExpressClientApp >> greetings: aString [
	self greetingsContainer textContent: aString
]

{ #category : #accessing }
PjHelloWorldExpressClientApp >> greetingsContainer [
	^self elementAt: #greetingsMessageContainer
]

{ #category : #initialization }
PjHelloWorldExpressClientApp >> initialize [

	super initialize.
	self
		onClickElement: self updateGreetingsButton
		do: [ self updateGreetings ].
	self onClickElement: self setNameButton do: [ self setName ]
]

{ #category : #accessing }
PjHelloWorldExpressClientApp >> nameInput [

	^ self elementAt: #nameTextInput
]

{ #category : #acting }
PjHelloWorldExpressClientApp >> setName [

	| providedName |
	providedName := self nameInput value.
	providedName size < 2 ifTrue: [ 
		^ window alert: 'Please provide a name with at least 2 characters' ].
	(window fetch: '/name' with: { (#method -> 'POST'). #body -> providedName } asJsObject) 
		then: [ :response | self setNameResponse: response ]
]

{ #category : #accessing }
PjHelloWorldExpressClientApp >> setNameButton [

	^self elementAt: #setNameButton
]

{ #category : #acting }
PjHelloWorldExpressClientApp >> setNameResponse: response [
	response ok ifFalse: [ ^window alert: 'Setting name failed!' ].
	self nameInput value: ''.
	self updateGreetings
]

{ #category : #acting }
PjHelloWorldExpressClientApp >> updateGreetings [

	(window fetch: '/greetings') then: [ :response | 
		response text then: [ :value | self greetings: value ] ]
]

{ #category : #accessing }
PjHelloWorldExpressClientApp >> updateGreetingsButton [

	^self elementAt: #updateGreetingsButton
]

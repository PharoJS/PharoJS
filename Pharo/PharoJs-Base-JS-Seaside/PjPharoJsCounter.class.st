Class {
	#name : #PjPharoJsCounter,
	#superclass : #WACounter,
	#traits : 'PjTPharoJsForSeaside',
	#classTraits : 'PjTPharoJsForSeaside classTrait',
	#classInstVars : [
		'scriptCache'
	],
	#category : #'PharoJs-Base-JS-Seaside'
}

{ #category : #accessing }
PjPharoJsCounter class >> handlerName [
	^ 'PharoJS/counter'
]

{ #category : #initialization }
PjPharoJsCounter class >> initialize [
	WAAdmin register: self asApplicationAt: self handlerName
]

{ #category : #hooks }
PjPharoJsCounter class >> pharoJsAppClass [
	^PjCounterBrowserApp
]

{ #category : #hooks }
PjPharoJsCounter class >> scriptCache [
	^scriptCache
]

{ #category : #hooks }
PjPharoJsCounter class >> scriptCache: jsCode [
	scriptCache := jsCode
]

{ #category : #rendering }
PjPharoJsCounter >> renderContentOn: html [
	super renderContentOn: html.
	html heading: 'Above is a Seaside Counter = Server side'.
	html horizontalRule.
	html heading: 'Below is a PharoJS Counter = Client side'.
	html heading id: #countDisplay; with: 0.
	html button
		id: #incrementButton;
		with: '++'.
	html space.
	html button
		id: #resetButton;
		with: 'Reset'.
]

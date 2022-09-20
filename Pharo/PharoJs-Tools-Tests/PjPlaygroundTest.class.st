Class {
	#name : #PjPlaygroundTest,
	#superclass : #TestCase,
	#instVars : [
		'playground',
		'window'
	],
	#category : #'PharoJs-Tools-Tests-Playground'
}

{ #category : #testing }
PjPlaygroundTest >> closeWindow [
	window ifNotNil: [ window delete ]
]

{ #category : #testing }
PjPlaygroundTest >> eval: statementsString [

	| codePresenter |
	codePresenter := playground firstPage text.
	^ codePresenter
		  evaluate: statementsString
		  onCompileError: [ :err | err pass ]
		  onError: [ :err | err pass ]
]

{ #category : #testing }
PjPlaygroundTest >> setUp [

	super setUp.
	self setUpPlayground.
	window := playground window
]

{ #category : #testing }
PjPlaygroundTest >> setUpPlayground [

	playground := PjWebApplication playground.
	playground title: 'PharoJS Playground Test'
]

{ #category : #testing }
PjPlaygroundTest >> tearDown [
	super tearDown.
	self closeWindow
]

{ #category : #testing }
PjPlaygroundTest >> testReadJsGlobal [
	|result|
	self shouldnt: [result := self eval: 'window.'] raise: Error.
	self assert: (result isKindOf: PjProxy).
	self assert: result asJSON equals: #window
]

{ #category : #testing }
PjPlaygroundTest >> testSendMessageToGlobal [
	|result|
	self shouldnt: [result := self eval: 'window document.'] raise: Error.
	self assert: (result isKindOf: PjProxy).
	self assert: result asJSON equals: #document
]

{ #category : #testing }
PjPlaygroundTest >> testSetNewVariable [
	|result| 
	self shouldnt: [result := self eval: 'newVar := 1.'] raise: Error.
	self assert: result equals: 1
]

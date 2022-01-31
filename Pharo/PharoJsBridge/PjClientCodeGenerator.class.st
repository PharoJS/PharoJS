"
A PjClientCodeGenerator generates the HTML that includes javascript code made available through the server to the client (typically on the browser).

Instance Variables
	converter:		<PjSmalltalkToJavaScriptBasicConverer>

converter
	- translates Smalltalk code into JavaScript

"
Class {
	#name : #PjClientCodeGenerator,
	#superclass : #Object,
	#instVars : [
		'titleString',
		'appClass',
		'htmlGenerator',
		'appClassDecorator'
	],
	#category : #'PharoJsBridge-Client-CodeGenerator'
}

{ #category : #accessing }
PjClientCodeGenerator class >> bridgeAppClassDecoratorClass [
	^ PjBridgeAppClassDecorator
]

{ #category : #public }
PjClientCodeGenerator class >> html [
	^self new html
]

{ #category : #generating }
PjClientCodeGenerator class >> websocketDelegateClass [
	^self bridgeAppClassDecoratorClass websocketDelegateClass
]

{ #category : #accessing }
PjClientCodeGenerator >> appClass [
	^ appClass
]

{ #category : #accessing }
PjClientCodeGenerator >> appClassDecorator [
	^ appClassDecorator
]

{ #category : #accessing }
PjClientCodeGenerator >> bridge: aBridge [
	appClassDecorator bridge: aBridge
]

{ #category : #accessing }
PjClientCodeGenerator >> bridgeAppClassDecoratorClass [
	^self class bridgeAppClassDecoratorClass
]

{ #category : #public }
PjClientCodeGenerator >> css [
	^ self cssUsing: self htmlGenerator
]

{ #category : #generating }
PjClientCodeGenerator >> cssUsing: aHtmlGenerator [
	^ (self appClass css) ifNotNil: [: css |
		aHtmlGenerator addCssLink: 'index.css'.
		css
	]
]

{ #category : #generating }
PjClientCodeGenerator >> decorateAppClass: anAppClass [
	appClass := anAppClass.
	appClassDecorator := self bridgeAppClassDecoratorClass rawAppClass: anAppClass.
	^appClassDecorator
]

{ #category : #generating }
PjClientCodeGenerator >> favicon [
	^ self appClass favicon
]

{ #category : #generating }
PjClientCodeGenerator >> generateHtmlUsing: aHtmlGenerator [
	(self appClass generateHtmlUsing: aHtmlGenerator) ifFalse: [
		aHtmlGenerator title: 'PharoJS:', self titleString.
		aHtmlGenerator add: 'h1' contents: 'PharoJS: Develop in Pharo, run in JavaScript'.
		aHtmlGenerator add: 'h2' contents: self titleString.
	].
	aHtmlGenerator addScriptUrl: 'index.js'.
]

{ #category : #public }
PjClientCodeGenerator >> html [
	self generateHtmlUsing: self htmlGenerator.
	^ self htmlGenerator html
]

{ #category : #generating }
PjClientCodeGenerator >> htmlGenerator [
	^ htmlGenerator ifNil: [htmlGenerator := PjHtmlGenerator new]
]

{ #category : #generating }
PjClientCodeGenerator >> resetHtmlGenerator [
	htmlGenerator := nil
]

{ #category : #accessing }
PjClientCodeGenerator >> titleString [
	^ titleString ifNil: [ '' ]
]

{ #category : #accessing }
PjClientCodeGenerator >> titleString: aString [
	titleString := aString
]

{ #category : #accessing }
PjClientCodeGenerator >> websocketDelegateClass [
	^ self class websocketDelegateClass
]

{ #category : #accessing }
PjClientCodeGenerator >> websocketDelegateClassName [
	^self websocketDelegateClass name
]

{ #category : #public }
PjClientCodeGenerator >> withClientLogging [
	^PjLoggingClientCodeGenerator new
]

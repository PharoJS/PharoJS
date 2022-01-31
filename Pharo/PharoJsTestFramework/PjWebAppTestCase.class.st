Class {
	#name : #PjWebAppTestCase,
	#superclass : #PjAppTestCase,
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #asserting }
PjWebAppTestCase >> assertInnerHtmlOfElement: domElement equals: expectedValue [
	self assert: domElement innerHTML equals: expectedValue
]

{ #category : #asserting }
PjWebAppTestCase >> assertInnerHtmlOfElementById: id equals: expectedValue [
	self assertInnerHtmlOfElement: (document getElementById: id) equals: expectedValue
]

{ #category : #asserting }
PjWebAppTestCase >> assertValueOfElement: domElement equals: expectedValue [
	self assert: domElement value equals: expectedValue
]

{ #category : #asserting }
PjWebAppTestCase >> assertValueOfElementById: id equals: expectedValue [
	self assertValueOfElement: (document getElementById: id) equals: expectedValue
]

{ #category : #'UI handling' }
PjWebAppTestCase >> changeElement: domElement value: newValue [
	domElement value: newValue.
	self dispatchEvent: #change to: domElement.
]

{ #category : #'UI handling' }
PjWebAppTestCase >> changeElementById: anId value: newValue [
	self changeElement: (document getElementById: anId) value: newValue
]

{ #category : #'UI handling' }
PjWebAppTestCase >> clickElement: domElement [ 
	self dispatchEvent: #click to: domElement.
]

{ #category : #'UI handling' }
PjWebAppTestCase >> clickElementById: aString [ 
	self clickElement: (document getElementById: aString).
]

{ #category : #'UI handling' }
PjWebAppTestCase >> dispatchEvent: eventName to: htmlElement [
	htmlElement dispatchEvent: (self newEvent: eventName)
]

{ #category : #'UI handling' }
PjWebAppTestCase >> newEvent: eventName [
	| event |
	event := document createEvent: #HTMLEvents.
   event initEvent: eventName with: true with: true.
	^event
]

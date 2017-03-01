Class {
	#name : #PjWebAppTestCase,
	#superclass : #PjAppTestCase,
	#pools : [
		'PjBrowserGlobals',
		'PjDomGlobals'
	],
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #testing }
PjWebAppTestCase class >> isAbstract [
	^self == PjWebAppTestCase or: [ ^super isAbstract ].
]

{ #category : #'suite parameters' }
PjWebAppTestCase class >> targetPlatforms [
	^ { PjSafari. PjFireFox. PjGoogleChrome }
]

{ #category : #'UI handling' }
PjWebAppTestCase >> clickElement: domElement [ 
	self dispatchEvent: 'click' to: domElement.
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
	event := document createEvent: 'HTMLEvents'.
   event initEvent: eventName with: true with: true.
	^event

]

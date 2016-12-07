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

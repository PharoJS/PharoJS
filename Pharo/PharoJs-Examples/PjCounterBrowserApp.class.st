Class {
	#name : #PjCounterBrowserApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'counter',
		'controller'
	],
	#category : #'PharoJs-Examples-Counter'
}

{ #category : #description }
PjCounterBrowserApp class >> appClasses [
	<pharoJsSkip>
	^super appClasses, {PjCounter. PjCounterController}
]

{ #category : #description }
PjCounterBrowserApp class >> appJsSubFolder [
	^'js'
]

{ #category : #accessing }
PjCounterBrowserApp >> countDisplay [
	^ self elementAt: 'countDisplay'
]

{ #category : #accessing }
PjCounterBrowserApp >> incrementButton [
	^ self elementAt: 'incrementButton'
]

{ #category : #'initialize-release' }
PjCounterBrowserApp >> initialize [
	super initialize.
	counter := PjCounter new.
	controller := PjCounterController new.
	controller counter: counter.
	controller countDisplay: self countDisplay.
	self resetButton addEventListener: #click block: [ controller reset ].
	self incrementButton addEventListener: #click block: [ controller increment ]
]

{ #category : #accessing }
PjCounterBrowserApp >> resetButton [
	^ self elementAt: 'resetButton'
]

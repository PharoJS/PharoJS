Class {
	#name : #PjCounterBrowserAppTest,
	#superclass : #PjWebAppTestCase,
	#instVars : [
		'countDisplay',
		'incrementButton',
		'resetButton'
	],
	#category : #'PharoJs-Examples-Counter'
}

{ #category : #'suite parameters' }
PjCounterBrowserAppTest class >> appClass [
	^PjCounterBrowserApp
]

{ #category : #testing }
PjCounterBrowserAppTest >> setUp [
	super setUp.
	countDisplay := app countDisplay.
	resetButton := app resetButton.
	incrementButton := app incrementButton.
]

{ #category : #testing }
PjCounterBrowserAppTest >> testClickOnIncrementButtonIncreasesCountAndUpdatesDisplay [
	1 to: 10 do: [ : expectedCount |
		incrementButton click.
		self assert: countDisplay innerHTML equals: expectedCount asString
	]
]

{ #category : #testing }
PjCounterBrowserAppTest >> testClickOnResetButtonSetsCountTo0 [
	3 timesRepeat: [incrementButton click.].
	resetButton click.
	self assert: countDisplay innerHTML equals: '0'
]

{ #category : #testing }
PjCounterBrowserAppTest >> testInitialCountDisplayIs0 [
	self assert: countDisplay innerHTML equals: '0'
]

Class {
	#name : #PjCounterBrowserAppTest,
	#superclass : #PjAppTestCase,
	#instVars : [
		'application',
		'countDisplay',
		'incrementButton',
		'resetButton'
	],
	#category : #'PharoJsExamples-Counter'
}

{ #category : #'suite parameters' }
PjCounterBrowserAppTest class >> appClass [
	^PjCounterBrowserApp
]

{ #category : #testing }
PjCounterBrowserAppTest class >> isAbstract [
	^self == PjCounterBrowserAppTest
]

{ #category : #testing }
PjCounterBrowserAppTest >> currentApp [
	self subclassResponsibility
]

{ #category : #testing }
PjCounterBrowserAppTest >> setUp [
	super setUp.
	application := self currentApp.
	countDisplay := application countDisplay.
	resetButton := application resetButton.
	incrementButton := application incrementButton.
	
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

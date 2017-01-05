Class {
	#name : #PjCounterBrowserApp,
	#superclass : #PjFileBasedBrowserApp,
	#instVars : [
		'counter',
		'controller'
	],
	#category : #'PharoJsExamples-Counter'
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

{ #category : #description }
PjCounterBrowserApp class >> setUpAppFolderPrompt [
	^ 'PharoJS: Folder for app ', self name, ' (see GIT repo https://github.com/bouraqadi/PharoJS.git sub-folder PharoJsExamples/Counter/) please?'.
]

{ #category : #accessing }
PjCounterBrowserApp >> countDisplay [
	^ self domElementAt: 'countDisplay'
]

{ #category : #accessing }
PjCounterBrowserApp >> incrementButton [
	^ self domElementAt: 'incrementButton'
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
	^ self domElementAt: 'resetButton'
]

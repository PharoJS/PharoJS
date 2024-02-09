Class {
	#name : #PjMultipageExpressClientExampleAppTest,
	#superclass : #PjMultipageExpressClientAppTest,
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #running }
PjMultipageExpressClientExampleAppTest >> click: buttonID [

	| button |
	button := document getElementById: buttonID.
	self deny: button isNil.
	button click
]

{ #category : #running }
PjMultipageExpressClientExampleAppTest >> pageAppClasses [

	^PjMultipageExpressClientExampleApp subclasses
]

{ #category : #running }
PjMultipageExpressClientExampleAppTest >> testNavigateFromPage1ToPage2AndToPage3 [

	self openPage: PjPage1InMultipageExpressExampleApp.
	self click: #goToPage2Button.
	self assertShowingPage:  PjPage2InMultipageExpressExampleApp.
	self click: #goToPage3Button.
	self assertShowingPage:  PjPage3InMultipageExpressExampleApp.
	self click: #goToPage1Button.
	self assertShowingPage:  PjPage1InMultipageExpressExampleApp.

]

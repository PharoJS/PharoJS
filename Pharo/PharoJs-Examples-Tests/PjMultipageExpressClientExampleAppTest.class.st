Class {
	#name : #PjMultipageExpressClientExampleAppTest,
	#superclass : #PjMultipageExpressClientAppTest,
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #accessing }
PjMultipageExpressClientExampleAppTest >> allPageBridges [
	^{bridgePage1 . bridgePage2 . bridgePage3}
]

{ #category : #running }
PjMultipageExpressClientExampleAppTest >> click: buttonID [

	| button |
	button := document getElementById: buttonID.
	self deny: button isNil.
	button click
]

{ #category : #running }
PjMultipageExpressClientExampleAppTest >> createPageBridges [

	bridgePage1 := PjPage1InMultipageExpressExampleApp bridge.
	bridgePage2 := PjPage2InMultipageExpressExampleApp bridge.
	bridgePage3 := PjPage3InMultipageExpressExampleApp bridge
]

{ #category : #running }
PjMultipageExpressClientExampleAppTest >> testNavigateFromPage1ToPage2AndToPage3 [

	self openPageOfBridge: bridgePage1 .
	self click: #goToPage2Button.
	self assertConnected: bridgePage2.
	self click: #goToPage3Button.
	self assertConnected: bridgePage3.
	self click: #goToPage1Button.
	self assertConnected: bridgePage1
]

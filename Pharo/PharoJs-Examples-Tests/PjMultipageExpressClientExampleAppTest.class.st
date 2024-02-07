Class {
	#name : #PjMultipageExpressClientExampleAppTest,
	#superclass : #PjMultipageExpressClientAppTest,
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-Examples-Tests-ExpressJS'
}

{ #category : #'suite parameters' }
PjMultipageExpressClientExampleAppTest class >> appClass [

	^PjPage1InMultipageExpressApp
]

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
PjMultipageExpressClientExampleAppTest >> initBridges [

	bridgePage1 := self bridge.
	bridgePage2 := PjPage2InMultipageExpressApp bridge.
	bridgePage3 := PjPage3InMultipageExpressApp bridge
]

{ #category : #running }
PjMultipageExpressClientExampleAppTest >> testNavigateFromPage1ToPage2AndToPage3 [

	self assertConnected: bridgePage1.
	self click: #goToPage2Button.
	self assertConnected: bridgePage2.
	self click: #goToPage3Button.
	self assertConnected: bridgePage3.
	self click: #goToPage1Button.
	self assertConnected: bridgePage1
]

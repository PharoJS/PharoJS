Class {
	#name : #PjPlayground,
	#superclass : #StPlayground,
	#instVars : [
		'bridge',
		'bridgeVar',
		'allJavascriptGlobals'
	],
	#category : #'PharoJs-Tools-Playground'
}

{ #category : #accessing }
PjPlayground class >> defaultTitle [

	^ 'PharoJS Playground'
]

{ #category : #opening }
PjPlayground class >> openFor: aPjBridge [
	| playground |
	playground :=  self new.
	playground open.
	playground initializeWithBridge: aPjBridge.
	^playground 
]

{ #category : #accessing }
PjPlayground >> bridge [
	^bridge
]

{ #category : #initialization }
PjPlayground >> initializeCommonBridge: aPjBridgeOrNil [
	super initialize.
	bridge := aPjBridgeOrNil.
	bridgeVar := (PjWorkspaceBridgeVariable key: #bridge value: bridge)
		playground: self;
		yourself
]

{ #category : #initialization }
PjPlayground >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenClosedDo: [ bridge stop ]
]

{ #category : #initialization }
PjPlayground >> initializeWithBridge: aPjBridge [

	aPjBridge startWithoutWaitingForClient.
	self initializeCommonBridge: aPjBridge.
	self title: 'PharoJS Playground: ' , aPjBridge clientTitle
]

{ #category : #accessing }
PjPlayground >> title [

	^self window title
]

{ #category : #accessing }
PjPlayground >> title: aString [
	self window title: aString
]

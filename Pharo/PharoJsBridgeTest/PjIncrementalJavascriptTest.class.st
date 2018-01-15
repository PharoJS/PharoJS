Class {
	#name : #PjIncrementalJavascriptTest,
	#superclass : #TestCase,
	#instVars : [
		'bridge'
	],
	#category : #'PharoJsBridgeTest-Tests'
}

{ #category : #testing }
PjIncrementalJavascriptTest >> testPolyfillLoad [
	| contents |
	bridge := PjTestBridge bridgeForApp: PjMinimalNodeApplication.
	bridge loadAllClasses: #().
	contents := bridge lastJavascript.
	self assert: (contents includesSubstring: ' WebSocket=Smalltalk.require("ws")').
	bridge loadClass: PjMinimalNodeApplication.
	contents := bridge lastJavascript.
	self deny: (contents includesSubstring: ' WebSocket=Smalltalk.require("ws")').

]

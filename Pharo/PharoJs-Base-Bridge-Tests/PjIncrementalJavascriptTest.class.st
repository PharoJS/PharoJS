Class {
	#name : #PjIncrementalJavascriptTest,
	#superclass : #TestCase,
	#instVars : [
		'bridge'
	],
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #testing }
PjIncrementalJavascriptTest >> testPolyfillLoad [
	| contents |
	bridge := PjTestBridge bridgeForAppClass: PjMinimalNodeApplication.
	bridge loadAllClasses: #().
	contents := bridge lastJavascript.
	self assert: (contents includesSubstring: ' WebSocket=Smalltalk.require("ws")').
	bridge loadClass: PjMinimalNodeApplication.
	contents := bridge lastJavascript.
	self deny: (contents includesSubstring: ' WebSocket=Smalltalk.require("ws")').
]
